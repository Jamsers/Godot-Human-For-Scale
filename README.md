# Godot-Human-For-Scale

Simple controllable character that you can use to run around in your [Godot](https://godotengine.org/) level to get a sense of scale. No input bindings or camera set up necessary, just drag and drop into your scene. The character is 5'10. (177.8 cm)

https://github.com/Jamsers/Godot-Human-For-Scale/assets/39361911/ea40c6ec-47b0-43da-a2c2-1e5539d293f6

[![Godot](https://img.shields.io/badge/Godot-478cbf?style=for-the-badge&logo=godot-engine&logoColor=white)](https://godotengine.org/)

## Usage

1. Clone or download this repository.  
2. Move the repository folder into your project folder.  
4. Drag and drop the player scene (`Human-For-Scale.tscn`) into the scene you want to walk around in.  
5. Run your scene.  

> [!IMPORTANT]  
> Make sure your scene has colliders for the floor at least, or the player will just fall through the map!

## Controls

| Action | Mouse/Keyboard |  Controller (Xbox) |
| - | :-: | :-: |
| **Capture/uncapture mouse** <br /> *Mouse is uncaptured on start!* | ESCAPE | START |
|  |  |  |
| **Move** | W-A-S-D | Left Stick |
| **Sprint** (Toggle) | SHIFT | Left Stick Button |
| **Jump** | SPACE | A |
| **Noclip** | TILDE (~) | D-pad Up |
|  |  |  |
| **Switch third person/first person** | V | BACK |
| **Zoom/focus** (Toggle) | Right Click | Left Trigger |
| **Switch third person camera shoulders** | TAB | Left Shoulder |
|  |  |  |
| **Pick up/throw object with physics gun** | Left Click | Right Trigger |
| **Turn flashlight on/off** | F | D-pad Down |

> [!TIP]  
> ***Mouse look not working?***  
> A Control node is likely capturing mouse input. Find that Control node, set its Mouse Filter to Pass/Ignore.  

> [!TIP]  
> ***Keyboard controls not working?***  
> A Control node is likely capturing keyboard input, most likely a button or text box. Find that Control node, set its Focus Mode to None.

## Editor Options

* You can enable depth of field for the zoom functionality. No camera attributes setup necessary.  
* You can disable the character's shadow in first person view.  
* You can enable audio, which will enable the audio listener, footstep sounds, and physics interactions sounds.  
* You can enable the physics gun, which allows you to pick up and throw RigidBodies.

![Editor Options](https://github.com/Jamsers/Godot-Human-For-Scale/assets/39361911/01ca7799-021c-46c1-a98a-c68c1dee7035)

## License

Unless stated otherwise within the [**`ATTRIBUTION`**](ATTRIBUTION) file or directly alongside specific files/folders, the following license applies:

Licensed under the MIT license.  
[![MIT license](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

Please refer to the [**`LICENSE`**](LICENSE) file for full details.

## Credits

Developed by [John James Gutib](https://github.com/Jamsers).

Uses the fantastic [mannequiny](https://github.com/GDQuest/godot-3d-mannequin/tree/master/godot/assets/3d/mannequiny) from [GDQuest](https://www.gdquest.com/)'s [godot-3d-mannequin](https://github.com/GDQuest/godot-3d-mannequin)!

Please refer to the [**`ATTRIBUTION`**](ATTRIBUTION) file for full details.
