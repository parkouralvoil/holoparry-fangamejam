extends Node

## convenient way of allowing player and enemy to inform everyone of their position
## intended to let skills autoaim at the enemy, BUT
## this is rlly bad practice pls do not do this for bigger projects

var player_global_position: Vector2
var enemy_global_position: Vector2

@onready var RNG: RandomNumberGenerator = RandomNumberGenerator.new()
