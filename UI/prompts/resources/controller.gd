@tool
class_name ControllerTextures
extends Resource

## Bottom action (PS X, Xbox/Steam A, Nintendo B)
@export var button_0: Texture2D = null
## Right action (PS O, Xbox/Steam B, Nintendo A)
@export var button_1: Texture2D = null
## Left action (PS □, Xbox/Steam X, Nintendo Y)
@export var button_2: Texture2D = null
## Top action (PS △, Xbox/Steam Y, Nintendo X)
@export var button_3: Texture2D = null
## Back (PS 1/2/3 Select, PS 4/5 Share, Xbox Back, Nintendo -)
@export var button_4: Texture2D = null
## Guide (PS PS button, Xbox home, Nintendo home)
@export var button_5: Texture2D = null
## Start (PS 1/2/3 Start, PS4/5 Options, Xbox menu, Nintendo +)
@export var button_6: Texture2D = null
## Left stick (PS L3, Xbox L/LS, Nintendo left stick)
@export var button_7: Texture2D = null
## Right stick (PS R3, Xbox R/RS, Nintendo right stick)
@export var button_8: Texture2D = null
## Left shoulder (PS L1, Xbox LB, Nintendo L)
@export var button_9: Texture2D = null
## Right shoulder (PS R1, Xbox RB, Nintendo R)
@export var button_10: Texture2D = null
## D-pad up
@export var button_11: Texture2D = null
## D-pad down
@export var button_12: Texture2D = null
## D-pad left
@export var button_13: Texture2D = null
## D-pad right
@export var button_14: Texture2D = null
## PS5 Microphone, Xbox Share, Nintendo capture
@export var button_15: Texture2D = null
## Paddle 1
@export var button_16: Texture2D = null
## Paddle 2
@export var button_17: Texture2D = null
## Paddle 3
@export var button_18: Texture2D = null
## Paddle 4
@export var button_19: Texture2D = null
## PS4/5 touchpad
@export var button_20: Texture2D = null


func get_texture(event: InputEvent) -> Texture2D:
	if not event is InputEventJoypadButton:
		return null

	var joypad_event := event as InputEventJoypadButton
	var button := joypad_event.button_index
	return get("button_" + str(button))
