class_name RoutePayoffSyncService
extends RefCounted

const RoutePresenterScript := preload("res://scripts/ui/route_presenter.gd")

static func sync_east_shelf_pocket_payoff(host) -> void:
	_sync_payoff(
		host,
		host.east_shelf_signal_core_halo,
		"EastShelfSpur/PocketEntrance/SignalCore/CoreHalo",
		host.east_shelf_signal_core_gem,
		"EastShelfSpur/PocketEntrance/SignalCore/CoreGem",
		host.east_shelf_signal_core_spark,
		"EastShelfSpur/PocketEntrance/SignalCore/CoreSpark",
		host.run_east_shelf_pocket_ping_recovered,
		"east_shelf"
	)

static func sync_blue_chimney_payoff(host) -> void:
	_sync_payoff(
		host,
		host.blue_chimney_survey_halo,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyHalo",
		host.blue_chimney_survey_gem,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyGem",
		host.blue_chimney_survey_spark,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveySpark",
		host.run_blue_chimney_draft_reading_recovered,
		"blue_chimney"
	)

static func sync_blackwater_trace_payoff(host) -> void:
	_sync_payoff(
		host,
		host.blackwater_trace_halo,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceHalo",
		host.blackwater_trace_gem,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceGem",
		host.blackwater_trace_spark,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceSpark",
		host.run_blackwater_trace_recovered,
		"blackwater_trace"
	)

static func sync_glass_kelp_reading_payoff(host) -> void:
	_sync_payoff(
		host,
		host.glass_kelp_reading_halo,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingHalo",
		host.glass_kelp_reading_shard,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingShard",
		host.glass_kelp_reading_spark,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingSpark",
		host.run_glass_kelp_reading_recovered,
		"glass_kelp"
	)

static func sync_hollow_reef_reading_payoff(host) -> void:
	_sync_payoff(
		host,
		host.hollow_reef_reading_halo,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingHalo",
		host.hollow_reef_reading_shard,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingShard",
		host.hollow_reef_reading_spark,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingSpark",
		host.run_hollow_reef_reading_recovered,
		"hollow_reef"
	)

static func sync_salvage_data_cache_payoff(host) -> void:
	_sync_payoff(
		host,
		host.salvage_data_cache_halo,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheHalo",
		host.salvage_data_cache_core,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheCore",
		host.salvage_data_cache_spark,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheSpark",
		host.run_salvage_data_cache_recovered,
		"salvage_data_cache"
	)

static func sync_salvage_manifest_payoff(host) -> void:
	_sync_payoff(
		host,
		host.salvage_manifest_halo,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestHalo",
		host.salvage_manifest_core,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestCore",
		host.salvage_manifest_spark,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestSpark",
		host.run_salvage_manifest_recovered,
		"salvage_manifest"
	)

static func sync_tideglass_sample_payoff(host) -> void:
	_sync_payoff(
		host,
		host.tideglass_sample_halo,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleHalo",
		host.tideglass_sample_core,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleCore",
		host.tideglass_sample_spark,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleSpark",
		host.run_tideglass_sample_recovered,
		"tideglass_sample"
	)

static func sync_outer_shelf_survey_payoff(host) -> void:
	_sync_payoff(
		host,
		host.outer_shelf_survey_halo,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/SurveyHalo",
		host.outer_shelf_survey_core,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/SurveyCore",
		host.outer_shelf_survey_spark,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/SurveySpark",
		host.run_outer_shelf_survey_recovered,
		"outer_shelf_survey"
	)

static func sync_rim_glass_reading_payoff(host) -> void:
	_sync_payoff(
		host,
		host.rim_glass_reading_halo,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/RimGlassReading/ReadingHalo",
		host.rim_glass_reading_core,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/RimGlassReading/ReadingCore",
		host.rim_glass_reading_spark,
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/RimGlassReading/ReadingSpark",
		host.run_rim_glass_reading_recovered,
		"rim_glass"
	)

static func _sync_payoff(
	host,
	halo_node: Polygon2D,
	halo_path: String,
	core_node: Polygon2D,
	core_path: String,
	spark_node: Polygon2D,
	spark_path: String,
	recovered: bool,
	payoff_id: String
) -> void:
	var halo := _resolve_polygon(host, halo_node, halo_path)
	var core := _resolve_polygon(host, core_node, core_path)
	var spark := _resolve_polygon(host, spark_node, spark_path)
	if halo == null or core == null or spark == null:
		return

	match payoff_id:
		"east_shelf":
			RoutePresenterScript.sync_east_shelf_pocket_payoff(halo, core, spark, recovered)
		"blue_chimney":
			RoutePresenterScript.sync_blue_chimney_payoff(halo, core, spark, recovered)
		"blackwater_trace":
			RoutePresenterScript.sync_blackwater_trace_payoff(halo, core, spark, recovered)
		"glass_kelp":
			RoutePresenterScript.sync_glass_kelp_reading_payoff(halo, core, spark, recovered)
		"hollow_reef":
			RoutePresenterScript.sync_hollow_reef_reading_payoff(halo, core, spark, recovered)
		"salvage_data_cache":
			RoutePresenterScript.sync_salvage_data_cache_payoff(halo, core, spark, recovered)
		"salvage_manifest":
			RoutePresenterScript.sync_salvage_manifest_payoff(halo, core, spark, recovered)
		"tideglass_sample":
			RoutePresenterScript.sync_tideglass_sample_payoff(halo, core, spark, recovered)
		"outer_shelf_survey":
			RoutePresenterScript.sync_outer_shelf_survey_payoff(halo, core, spark, recovered)
		"rim_glass":
			RoutePresenterScript.sync_rim_glass_reading_payoff(halo, core, spark, recovered)

static func _resolve_polygon(host, node: Polygon2D, path: String) -> Polygon2D:
	if node != null:
		return node
	return host.get_node_or_null(path) as Polygon2D
