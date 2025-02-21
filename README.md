![sakuyaLogo](https://github.com/user-attachments/assets/75ad151c-d589-4f8f-a259-eb2d09882cc4)
# SAKUYA
Sakuya is a Godot 4 addon, adding simple command line to your game. The plugin is quite simple and easily expandable, allowing user to quickly implement new commands.
## Instalation
Download this repository and add the `sakuya/` directory into the `addons/` directory inside your project. Next enable it inside 
## Configuration
After enabling the plugin, singleton `SakuyaCLI` should be added. To add new commands, you need to create a `SakuyaCommand` resource and extend its script, overwriting the `execute` function. This addon has `help` command implemented, so you can use it as a reference.

You can configure `SakuyaCLI` scene via export variables, overriding its theme, changing display modes, activation key and logging level.

To make your command work, you need to add your respective `SakuyaCommand` resource to the `SakuyaCLI`'s Loaded Commands variable.

If you have any questions, feel free to open new github Issue!

This projects uses images from [BootstrapIcons](https://icons.getbootstrap.com/), licenced under the MIT license.
