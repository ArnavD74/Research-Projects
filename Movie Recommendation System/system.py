def read_ratings_data(f):
    import pandas as pd
    df = pd.read_csv(f, header=None, names=['user_id', 'movie_id', 'rating'])
    ratings_dict = df.groupby('movie_id')['rating'].apply(list).to_dict()
    return ratings_dict

def read_movies_data(f):
    import pandas as pd
    df = pd.read_csv(f, sep='|', header=None, index_col=0, names=["title", "year", "genre"])
    df = df.sort_index()
    return df[['title', 'year', 'genre']]


def get_movie(movies_df, movie_id):
    import pandas as pd
    
def create_genre_dict(movies_df):
    import pandas as pd
    genre_dict = {}
    
    for index, row in movies_df.iterrows(): #Iterate over DataFrame rows as (index, Series) pairs.
        genres = row['genre'].split(',')
        for genre in genres:
            genre = genre.strip()
            if genre not in genre_dict:
                genre_dict[genre] = []
            genre_dict[genre].append(index) 
    
    return genre_dict


def calculate_average_rating(ratings_dict, movies_df): 
    import pandas as pd
    avg_ratings = pd.Series({movie_id: sum(ratings)/len(ratings) for movie_id, ratings in ratings_dict.items() if ratings})
    avg_ratings = avg_ratings[avg_ratings.index.isin(movies_df.index)].sort_index()
    return avg_ratings


def get_popular_movies(avg_ratings, n=10):
    import pandas as pd
    sorted_movies = avg_ratings.sort_values(ascending=False)
    return sorted_movies.head(n)

def filter_movies(avg_ratings, thres_rating=3):
    import pandas as pd
    filtered_movies = avg_ratings[avg_ratings >= thres_rating]
    return filtered_movies.to_dict()

def get_popular_in_genre(genre, genre_to_movies, avg_ratings, n=5):
    import pandas as pd
    movies_in_genre = genre_to_movies.get(genre, [])
    genre_ratings = avg_ratings[avg_ratings.index.isin(movies_in_genre)]
    sorted_genre_ratings = genre_ratings.sort_values(ascending=False)
    return sorted_genre_ratings.head(n)
    
    
def get_genre_rating(genre, genre_to_movies, avg_ratings):
    import pandas as pd
    movies = genre_to_movies.get(genre, [])
    total_rating = 0
    for movie in movies:
        total_rating += avg_ratings.get(movie, 0)
    
    if len(movies) == 0:
        return 0
    
    return total_rating / len(movies)

def get_movie_of_the_year(year, avg_ratings, movies_df):
    import pandas as pd
    avg_ratings_named = avg_ratings.rename("avg_rating")
    movies_df_reset = movies_df.reset_index() #fix to movie_id
    movies_df_reset.rename(columns={'index': 'movie_id'}, inplace=True) #rename to match

    movies_of_the_year = movies_df_reset[movies_df_reset['year'] == year]
    rated_movies = movies_of_the_year.join(avg_ratings_named, on='movie_id') #join movies with avg_ratings

    if rated_movies.empty or rated_movies['avg_rating'].isna().all():
        return None

    highest_rated_movie = rated_movies[rated_movies['avg_rating'] == rated_movies['avg_rating'].max()]
    return highest_rated_movie['title'].iloc[0]
    

def read_user_ratings(f):
    import pandas as pd
    df = pd.read_csv(f, header=None, names=['user_id', 'movie_id', 'rating'])
    user_movies = {}

    for index, row in df.iterrows(): #Iterate over DataFrame rows as (index, Series) pairs.
        user_id, movie_id, rating = row['user_id'], row['movie_id'], row['rating']

        if user_id in user_movies:
            user_movies[user_id].append((movie_id, rating))
        else:
            user_movies[user_id] = [(movie_id, rating)]

    return user_movies

def get_user_genre(user_id, user_to_movies, movies_df):
    import pandas as pd
    
    if user_id not in user_to_movies:
        return None

    genre_ratings = {}
    genre_counts = {}

    for movie_id, rating in user_to_movies[user_id]:
        genre = movies_df.at[movie_id, 'genre']
        if genre in genre_ratings:
            genre_ratings[genre] += rating
            genre_counts[genre] += 1
        else:
            genre_ratings[genre] = rating
            genre_counts[genre] = 1

    for genre in genre_ratings:
        genre_ratings[genre] /= genre_counts[genre]

    top_genre = max(genre_ratings, key=genre_ratings.get)

    return top_genre

def recommend_movies(user_id, user_to_movies, movies_df, avg_ratings):
    import pandas as pd

    top_genre = get_user_genre(user_id, user_to_movies, movies_df)
    genre_movies = movies_df[movies_df['genre'] == top_genre]

    rated_movies = [movie_id for movie_id, _ in user_to_movies[user_id]] #remove previously rated
    genre_movies = genre_movies[~genre_movies.index.isin(rated_movies)]

    recommended_ratings = avg_ratings[avg_ratings.index.isin(genre_movies.index)]
    return recommended_ratings.sort_values(ascending=False).head(3)