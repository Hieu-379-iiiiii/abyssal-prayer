class_name InventoryComponent
extends Node

signal inventory_changed

@export var inventory_size: int = 20

# Each slot contains an item and its quantity.
var slots: Array[Dictionary] = []

func _ready() -> void:
	slots.resize(inventory_size)

	for i in range(inventory_size):
		slots[i] = {
		"item": null,
		"quantity": 0
	}


func add_item(item: ItemData, amount: int = 1) -> bool:
	if item == null or amount <= 0:
		return false
# Stack with existing items first.
	if item.is_stackable:
		for slot in slots:

			if slot["item"] == item:
				var available = item.max_stack - slot["quantity"]

				if available > 0:
					var added = mini(amount, available)

					slot["quantity"] += added
					amount -= added

					if amount <= 0:
						inventory_changed.emit()
						return true

# Find empty slots.
	for slot in slots:
		if slot["item"] == null:
			var added = mini(amount, item.max_stack)
			slot["item"] = item
			slot["quantity"] = added

			amount -= added

			if amount <= 0:
				inventory_changed.emit()
				return true

	inventory_changed.emit()
	return false


func remove_item(slot_index: int, amount: int = 1) -> bool:

	if slot_index < 0 or slot_index >= slots.size():
		return false

	var slot = slots[slot_index]

	if slot["item"] == null or amount <= 0:
		return false

	if slot["quantity"] < amount:
		return false

	slot["quantity"] -= amount

	if slot["quantity"] <= 0:
		slot["item"] = null
		slot["quantity"] = 0

	inventory_changed.emit()
	return true
