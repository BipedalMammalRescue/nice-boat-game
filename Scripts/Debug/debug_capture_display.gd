extends Label
class_name DebugCaptureDisplay

func show_poi(poi: PoiData) -> void:
	text = "Description: {0}".format([poi.flavor_text])
