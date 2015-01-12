//= require chosen-jquery

jQuery ->
  $('select#event_user_id').chosen(search_contains: true)
  $('select#event_location_id').chosen(search_contains: true)
  $('select#job_location_id').chosen(search_contains: true)
  $('select#topic_user_id').chosen(search_contains: true)
  $('select#topic_event_id').chosen(search_contains: true)
  $('select#material_user_id').chosen(search_contains: true)
  $('select#material_event_id').chosen(search_contains: true)
