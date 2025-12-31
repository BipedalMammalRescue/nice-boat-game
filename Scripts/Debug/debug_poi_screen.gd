extends Label
class_name DebugPoiScreen

func _on_scanner_scan_result(poiObj: PointOfInterest) -> void:
	var poi = poiObj.data
	var total_mass = poi.carbon_mass + poi.iron_mass + poi.silicon_mass
	var carbon_percentage = floor(poi.carbon_mass / total_mass * 100)
	var iron_percentage = floor(poi.iron_mass / total_mass * 100)
	var silicon_percentage = floor(poi.silicon_mass / total_mass * 100)
	
	text = "Carbon: {0}% \nIron: {1}% \nSilicon: {2}%".format([
		carbon_percentage, 
		iron_percentage, 
		silicon_percentage])
