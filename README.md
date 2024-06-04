# axis_assignment

# Flutter Movie Database App

This Flutter application is built using the themoviedb.org API. It showcases popular people (actors,
directors, etc.), their details, and images. Users can also save images locally.

## Features

- Display a list of popular people with infinite scrolling
- View detailed information about a selected person
- Grid view of a person's images
- Full-size image view with the option to save locally

## Bonus Features I added

- Offline data storage, Save and display the list of people from a local database when offline
- Simple animations and UI enhancements
- Pan and zoom functionality in image preview
- Localization setup

## State Management

- State management is handled using [Bloc].

## APIs

- The app uses the [themoviedb.org](https://developers.themoviedb.org/3) API. Ensure you have an
  account and an API key to use the app.

## Setup and Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/ammarelgml/axis_assignment.git
    ```

2. Navigate to the project directory:
   ```sh
    cd axis_assignment
    ```

3. Install the dependencies:
   ```sh
   flutter pub get
    ```

4. Add your API_KEY in the Constants file: (I will leave mine to make your job easier)
   ```sh
    const String apiKey = 'YOUR_API_KEY';
    ```

5. Run the app:
   ```sh
   flutter run
   ```


## Screenshots

<img src="https://github.com/ammarelgml/axis_assignment/assets/62309234/e97c8eb3-4d79-47a7-ae1f-e76de841c0c9" width="200"/>

<img src="https://github.com/ammarelgml/axis_assignment/assets/62309234/cc977859-2c3e-457e-a3a0-f84502e12cad" width="200"/>

<img src="https://github.com/ammarelgml/axis_assignment/assets/62309234/5ef4fd65-6ac4-47a3-b295-3584589a3f03" width="200"/>

<img src="https://github.com/ammarelgml/axis_assignment/assets/62309234/0557d1c0-483e-4698-b873-995b888467a5" width="200"/>



## Contact

For any inquiries, please reach out to:

- Ammar Elgamal: [ammar.elgml@gmail.com](mailto:ammar.elgml@gmail.com)
- LinkedIn: [Ammar Elgamal](https://www.linkedin.com/in/ammar-elgml/)
