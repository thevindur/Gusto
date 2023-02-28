import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# Load the dataset containing ingredients and recipes
df = pd.read_csv("recipes.csv")

# Pre-process the ingredients and recipes
tfidf = TfidfVectorizer(stop_words="english")
df["ingredients_text"] = df["ingredients"].apply(lambda x: " ".join(x))
ingredients_matrix = tfidf.fit_transform(df["ingredients_text"])

def generate_recipe(ingredients):
    # Convert the input ingredients into a vector
    input_vector = tfidf.transform([" ".join(ingredients)])

    # Compute the cosine similarity between the input ingredients and all recipes
    cosine_similarities = cosine_similarity(input_vector, ingredients_matrix).flatten()

    # Find the index of the recipe with the highest cosine similarity
    index = cosine_similarities.argmax()

    # Return the recipe with the highest cosine similarity
    return df.iloc[index]["recipe"]

# Example usage
ingredients = ["chicken", "tomatoes", "olive oil"]
recipe = generate_recipe(ingredients)
print(recipe)