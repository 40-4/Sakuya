![sakuyaLogo](https://github.com/user-attachments/assets/75ad151c-d589-4f8f-a259-eb2d09882cc4)
# SAKUYA
Sakuya 2.0 is a complete rewrite of the addon, leveraging new 4.5 features, making it easier to debug Your game. It provides a customizable command console, using resource-based system, allowing You to quickly add new commands. It is not compatible with 1.1 version, however rewriting the commands should be pretty simple.

2.1 versions are not compatible with 2.0 versions!

## Instalation
Head on to releases and put the ``/sakuya`` directory into the ``/addons`` directory. Then enable it in project settings and You're done! 

After enabling the plugin, singleton `SakuyaRoot` should be added. To add new commands, You need to create a `SakuyaCommand` resource and extend its script, overwriting the `execute` function. This addon has ``help`` command implemented, so You can use it as a reference.

## Screenshots
<img width="1172" height="702" alt="Screenshot showing Sakuya Plugin in use" src="https://github.com/user-attachments/assets/2cb92822-056c-4af7-bc21-7164d116a704" />
<img width="1172" height="702" alt="Screenshot showing Sakuya Plugin in use" src="https://github.com/user-attachments/assets/35f950cf-04f8-4462-94a5-0ac0e1fbd0e5" />
<img width="1172" height="702" alt="Screenshot showing Sakuya Plugin in use" src="https://github.com/user-attachments/assets/11f64cac-163b-404b-845c-1f4ea4881860" />
<img width="1172" height="702" alt="Screenshot showing Sakuya Plugin in use" src="https://github.com/user-attachments/assets/a0b34d93-7aff-403f-826c-7dbbc87d5f7b" />
<img width="1172" height="702" alt="Screenshot showing Sakuya Plugin in use" src="https://github.com/user-attachments/assets/d726dd95-d753-4444-986f-9e13e0f353fd" />
<img width="1172" height="702" alt="Screenshot showing Sakuya Plugin in use" src="https://github.com/user-attachments/assets/e6a8fccc-5377-457f-9ac0-c3caac001783" />

# How to use
## Main Settings:
You can modify many parts of Sakuya interface through the export variables in the ``SakuyaRoot`` scene.
<img width="538" height="386" alt="SakuyaRoot export variables" src="https://github.com/user-attachments/assets/8f61a673-fd60-476a-bf4a-4530bdb8ac91" />

Out of the box, Sakuya has this settings:
- **Send Input Feedback** - shows the command user has inputted, prefixed with a gray ``>`` symbol
- **Show Time** - shows time of the output, based on the system time
- **Send Prints** - connects ``stdout`` to the output of the terminal via Godot Logger class
- **Send Errors** - connects ``stderr`` to the output of the terminal via Godot Logger class. Shows script backtraces. Works for warnings too
- **Terminal Style** - changes the terminal look. Currently only 2 modes are implemented, although
- **Custom Terminal** - **!EXPERIMENTAL!** alllows the user to connect their own custom terminal scene
- **Trigger Button** - changes which button shows and hides the terminal
- **Command List** - array holding every loaded command

## Commands:
To create a new command, You have to create new ``SakuyaCommand`` resource, and corresponding script.
By default, resource have those fields:
- **Alias** - name of the command, keyword by which it is invoked
- **Argument Count** - how many arguments the command needs to not throw a "wrong argument count" error
- **Description** - this is self-explanatory

If Your command takes only one number of arguments, You only need to override the ``execute()`` function. ``SakuyaCommand`` also provides the ``context`` variable, which holds the whole command and its arguments as a PackedStringArray.

If You want Your command to have more than one number of valid arguments, You'll need to override the ``check_arg_count()`` function.

The project includes ``help.tscn`` resource and ``help.gd`` script which is heavily commented, so You can use it as a reference.

To make Your command accessible through the terminal, You have to add the resource to the ``command_list`` array in the ``SakuyaRoot`` singleton.

## Advanced toggle
Sakuya by default creates an action in an Action Map which uses the ``trigger_button`` key as a toggle for the terminal. To create more advanced toggle (for example with Shift or using Joypad) You can create ``sakuya_toggle`` action by Yourself, and assign it to whatever fits Your needs. Plugin detects if the ``sakuya_toggle`` action exists, and wont override it.

## !EXPERIMENTAL! Custom Terminals
I've made Sakuya so it's easy to customize. Very barebones terminal needs only few things:
- Root needs a script - if You don't need extending any nodes, You can use ``SakuyaTerminal`` class.
  - However, if You need to extend other class, just make an ``IO`` variable.
- Add the ``SakuyaIO`` scene to the tree. Make sure the ``IO`` variable points to it.
- ``SakuyaIO`` needs both ``input`` and ``output`` to function. Input is a ``LineEdit``, output is a ``RichTextLabel``.  

In theory, that's all that is needed. I'm marking that as Experimental, cause I haven't tested it, if You find any issues, please let me know!

## Attribution
This projects uses images from [BootstrapIcons](https://icons.getbootstrap.com/), as well as [Cozette](https://github.com/the-moonwitch/Cozette) font, both licenced under the MIT license.

If You have any questions or have an idea for new features, feel free to open new Github Issue!
