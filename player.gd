extends CharacterBody2D

var velocidad = 100
var salto = 200
var gravedad = 400

func _physics_process(_delta):
	
	velocity.y += gravedad*_delta
	
	if Input.is_action_pressed("Right"):
		velocity.x = velocidad
	
	elif Input.is_action_pressed("Left"):
		velocity.x = -velocidad
		
	else:
		velocity.x = 0
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("salto"):
			velocity.y = -salto
	
	
	move_and_slide()
	animaciones()

func _input(_event):
	if Input.is_action_just_pressed("Attack") and is_on_floor():
		set_physics_process(false)
		$AnimationPlayer.play("Atacar")
		await $AnimationPlayer.animation_finished
		set_physics_process(true)


func animaciones():
	if velocity.x > 0:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play("run")
	elif velocity.x < 0:
		$Sprite2D.flip_h = true
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")
		
	if velocity.y < 0:
		$AnimationPlayer.play("Saltar")
		
	elif velocity.y > 0:
		$AnimationPlayer.play("fall")
		
		
	if Input.is_action_pressed("crouch") and is_on_floor():
		$AnimationPlayer.play("crouch")
		velocidad = 25
		salto = 110
	else:
		salto = 200
		velocidad = 100 
		
	
	
	
	



func _on_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Los-Enemys"):
		body.queue_free()
