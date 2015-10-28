module Zai where 

{-| This module provides Material Design Helpers.

# Device Independence Helpers

@docs dp 

# Elevation Filters
@docs elevationFilter, allElevationFilters

-}
import Svg exposing (Svg, g, svg, rect, defs, feFlood, feComposite, feOffset, feGaussianBlur, feBlend, feColorMatrix, circle)
import Svg.Attributes exposing (..)


{-| Converts pixels to device independent pixels -}
dp : Int -> String 
dp px = toString px

{-| A list with filters for all levels of elevation from 1 to 24 -}
allElevationFilters : List Svg
allElevationFilters = List.map elevationFilter [1..24]

{-| Given an elevation returns a shadow filter named like "height-1" -}
elevationFilter : Int -> Svg
elevationFilter elevation =
  let 
      sElev = toString elevation
  in 
    Svg.filter 
        [style "color-interpolation-filters:sRGB;", id ("height-"++sElev),  x "-100%", y "-100%", width "300%", height "400%"] 
        [ feFlood 
            [ floodOpacity "0.4"
            , floodColor "rgb(0,0,0)"
            , result "flood"] []

        , feComposite 
            [ in' "flood"
            , in2 "SourceGraphic"
            , operator "in"
            , result "comp"] []

        , feOffset 
            [ dx "0"
            , dy sElev
            , result "offset"] []

        , feGaussianBlur 
            [ in' "offset"
            , stdDeviation sElev
            , result "blur"] []

        , feBlend 
            [ in' "SourceGraphic"
            , in2 "blur"
            , mode "normal"] []

        ]

