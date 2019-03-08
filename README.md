# Who Wants To Be a Millionbear

Who Wants To Be a Millionbear is a CLI trivia game with a title and concept inspired by the well-known and loved, bears. It strives to bring life to the mundanity of the console with gratuitous use of ASCII and graphics, while still complementing the gameplay.

Users can test their trivia knowledge while our program showboats all over their console. But can you handle the pressure of avoiding embearassment in front of Alex Trebear? There's only one way to find out.


## Prerequisites
The following instructions are for macOS.

You will need Homebrew installed for the installation of an external dependency. https://brew.sh/

## Installation and Setup
First, clone or download the repository. There are Ruby scripts available for installing dependencies and initializing the database in the project directory.

For the full visual experience with graphics in the console, run `setup.rb`.
```sh
$ ruby setup.rb
```
For the lite version without graphics, run `setup_lite.rb`.
```sh
$ ruby setup_lite.rb
```

After installing dependencies, these scripts will run rake tasks to initialize the database by creating and seeding the tables.

## Usage
You can run the game by using the `run` rake task.
```sh
$ rake run
```

== INSERT DEMO VIDEO HERE ==

## About the Program

== IMPLEMENTATION DETAILS ==

## Uninstall
You can uninstall the external dependency by running
```sh
$ ruby uninstall.rb
```
## Contributing
Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## License

This project is licensed under the Learn.co Educational Content License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgements
* The quick wits of Anders & Molly for their suggestion of the bear theme that has no fur-ther meaning
* The projects by the first cohort and their introduction of ASCII art, for better or for worse


<small><center>Made with 🐻 &nbsp;by Jen & Bri</center></small>
