![sakuyaLogo](https://github.com/user-attachments/assets/75ad151c-d589-4f8f-a259-eb2d09882cc4)
# SAKUYA
Sakuya 2.0 is a complete rewrite of the addon, leveraging new 4.5 features, making it easier to debug your game. It provides a customizable command console, using resource-based system, allowing you to quickly add new commands. It is not compatible with 1.1 version, however rewriting the commands should be pretty simple.
## Instalation
Head on to releases and put the ``/sakuya`` directory into the ``/addons`` directory. Then enable it in project settings and you're done! 
## Configuration
After enabling the plugin, singleton `SakuyaRoot` should be added. To add new commands, you need to create a `SakuyaCommand` resource and extend its script, overwriting the `execute` function. This addon has ``help`` command implemented, so you can use it as a reference.

You can configure `SakuyaRoot` scene via export variables, overriding its theme, changing display modes ect... I've made the system easily customizable so you can make Your own GUI!

To make your command work, you need to add your respective `SakuyaCommand` resource to the `SakuyaRoot`'s ``command_list`` variable.

If you have any questions or have an idea for new features, feel free to open new Github Issue!

This projects uses images from [BootstrapIcons](https://icons.getbootstrap.com/), as well as [Cozette](https://github.com/the-moonwitch/Cozette) font, both licenced under the MIT license.
