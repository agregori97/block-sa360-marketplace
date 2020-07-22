view: advertiser_conversion_events {
  sql_table_name: `SA360.AdvertiserFloodlightAndDeviceStats_21700000000010391`
    ;;

  dimension_group: _data {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}._DATA_DATE ;;
  }

  dimension_group: _latest {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}._LATEST_DATE ;;
  }

  dimension: advertiser_id {
    type: string
    sql: ${TABLE}.advertiserId ;;
  }

  dimension: agency_id {
    type: string
    sql: ${TABLE}.agencyId ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: device_segment {
    type: string
    sql: ${TABLE}.deviceSegment ;;
  }

  dimension: dfa_actions {
    type: number
    sql: ${TABLE}.dfaActions ;;
  }

  dimension: dfa_advertiser_id {
    type: string
    sql: ${TABLE}.dfaAdvertiserId ;;
  }

  dimension: dfa_network_id {
    type: string
    sql: ${TABLE}.dfaNetworkId ;;
  }

  dimension: dfa_revenue {
    type: number
    sql: ${TABLE}.dfaRevenue ;;
  }

  dimension: dfa_transactions {
    type: number
    sql: ${TABLE}.dfaTransactions ;;
  }

  dimension: dfa_weighted_actions {
    type: number
    sql: ${TABLE}.dfaWeightedActions ;;
  }

  dimension: floodlight_activity_id {
    type: string
    sql: ${TABLE}.floodlightActivityId ;;
  }

  dimension: floodlight_group_id {
    type: string
    sql: ${TABLE}.floodlightGroupId ;;
  }

  ##### Keyword Standard Metric Aggregates #####

  measure: total_actions {
    type: sum
    sql: ${dfa_actions} ;;
  }

  measure: total_weighted_actions {
    type: sum
    sql: ${dfa_weighted_actions} ;;
  }

  measure: total_transactions {
    type: sum
    sql: ${dfa_transactions} ;;
  }

  ##### Keyword Conversion Metrics #####

  measure: total_revenue {
    type: sum
    value_format_name: usd
    sql: ${dfa_revenue} ;;
  }

  measure: ROAS {
    label: "Percent ROAS"
    description: "Associated revenue divided by the total cost"
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${total_revenue} / NULLIF(${advertiser_events.total_cost},0) - 1 ;;
  }

  measure: cost_per_acquisition {
    label: "Cost per Acquisition (CPA)"
    description: "Average cost per conversion"
    type: number
    value_format_name: usd
    sql: ${advertiser_events.total_cost}*1.0/NULLIF(${total_actions},0) ;;
  }
}