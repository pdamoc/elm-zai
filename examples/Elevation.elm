import Zai exposing (allElevationFilters, Action(..), MaterialColor(..), zFill, dp, dropShadow, colorToString, patterns)

import StartApp
import Effects exposing (Never, Effects)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)
import Task exposing (Task)
import String
import Window
import Time exposing (Time)
import Keyboard

import Signal exposing (message)

textureBase = "http://www.transparenttextures.com/patterns/"

slide : (Int, Int) -> Svg -> Svg
slide coord elem =
    g [ transform <| "translate " ++ (toString coord)][elem]


blackLinen = "http://www.transparenttextures.com/patterns/black-linen.png"

texturedColor c t =
    fill <| (colorToString c) ++ "url("++t++")"

box : Signal.Address Action -> String -> number -> Svg
box address name elevation =
    let
        e = toString elevation
        filterName = "filter:url(#height-"++e++")"

        y' = elevation*100

    in
        g
            [ onMouseOver (message address MouseOver)
            , onMouseOut (message address MouseOut)
            , onMouseDown (message address MouseClick)
            , onMouseUp (message address MouseOut)
            , fontFamily "Roboto"
            , fontWeight "500"
            , Svg.Attributes.cursor "pointer"
            ]
        [ rect
            [ width "150px", height "36px", zFill IndigoA400
            , Svg.Attributes.style filterName, rx "2px", ry "2px"
            ] []
        , Svg.text' [x  "75", y "24", textAnchor "middle", fill "white"][Svg.text <| String.toUpper name]
        , rect
            [ width "150px", height "36px", fill "rgba(0,0,0,0.01)"
            , rx "2px", ry "2px"
            ] []
        ]


getPattDefs color =
    [ pattern [id "simplehorizontal.base", patternUnits "userSpaceOnUse", width "20", height "9"]
        [ rect [ fill "#f2f2f2", height "9", width "20"] []
        , rect [ fill "#e7e7e7", height "2", width "20"] []
        , rect [ fill "#ececec", height "3",  width "20", y "2"] []
        ]
    , pattern [id "simplehorizontal", patternUnits "userSpaceOnUse", width "20", height "9"]
        [g []
        [ rect [ fill color, height "9", width "20"] []
        , rect [ fill "url(#simplehorizontal.base", fillOpacity "0.8", height "2", width "20", transform "scale(1, 0.5)"] []
        ]]
    , pattern [id "zig-zag", patternUnits "userSpaceOnUse", width "10", height "10"]
        [ image [xlinkHref "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAO0lEQVQY02NgoAVQJkpVcXExH5CSIaAMIj99+nR2PCbLQA1jQFaMbrIyiiI0ZyjjVYSuGGoDUR4kDwAA0u8QeBv9liAAAAAASUVORK5CYII=", x "0", y "0", width "10", height "10"] []
        ]
    ]


getColoredPattern color pat =
    let
        name = (toString color) ++ pat
        patFill = "url(#"++pat++")"
    in
        pattern [id name, patternUnits "userSpaceOnUse", width "100%", height "100%"]
        [ rect [ fill (colorToString color), height "100%", width "100%"] []
        , rect [ fill patFill, height "100%", width "100%", fillOpacity "0.5"] []
        ]


yellow200PD = getPattDefs (colorToString Yellow200)
yellow400PD = getPattDefs (colorToString Yellow400)

lop = ["horizontalstripes", "greenstripes", "honeycomb", "honeycomb2", "chevrons", "carbonfiber", "microbialmat", "checkerboard", "waves", "verticalstripes", "shippo", "halfrombes", "transparent", "simplehorizontal", "whitecarbon", "crossstripes", "subtledots", "thinstripes", "specklednoise"]

bits offset =
    let
        renderFold name (off, acc) =
            let
                xy = (toString (off*1)++", "++(toString (100+(off*0.2))))
                el = dropShadow 1 <| g [transform ("translate("++ xy ++")")] [rect [ width "300", height "300", fill ("url(#"++name++")"), rx "20px", ry "20px"] []]
            in
                (off+200, el::acc)
    in
        snd <| List.foldl renderFold (offset, []) lop

view : Signal.Address Action -> Model -> Svg
view address model =
    let
        (w, h) = model.size
        vb = ("0 0 " ++ w ++ " "++h)
        t2 = "translate(735, 320), rotate("++(toString model.angle)++", 0, 0)"
    in
        svg [width w, height h, viewBox vb]
        ([ defs []
            (patterns++allElevationFilters++([getColoredPattern Cyan600 "honeycomb2"]))
        , rect [ width w, height h, zFill Yellow200] []

        , slide (400, 200) <| box address "Bello" model.elevation
        , dropShadow 16 <| rect [ width "300", height h, fill "#58A4C2", opacity "0.5"] []


        , slide (400, 300) <| rect [ width "25", height "300", fill "url(#honeycomb)", rx "2px", ry "2px", Svg.Attributes.style "filter:url(#height-2)"] []
        , slide (445, 300) <| rect [ width "50", height "300", fill "white", rx "2px", ry "2px", Svg.Attributes.style "filter:url(#height-2)"] []
        , slide (515, 300) <| rect [ width "100", height "300", fill "white", rx "2px", ry "2px", Svg.Attributes.style "filter:url(#height-2)"] []

        , dropShadow 1 <| g [transform "translate(715, 300), rotate(30, 0, 0)"] [rect [ width "400", height "400", zFill Cyan200, rx "2px", ry "2px"] []]
        , dropShadow 1 <| g [transform "translate(715, 310), rotate(30, 0, 0)"] [rect [ width "400", height "400", fill "url(#honeycomb)", rx "20px", ry "20px"] []]
        , dropShadow 1 <| g [transform "translate(915, 610)"] [rect [ width "400", height "400", fill "url(#Cyan600honeycomb2)", rx "20px", ry "20px"] []]
        , dropShadow 2 <| g [transform "translate(1015, 710)"] [text' [] [text "Hello"]]
         ]++(bits 200))

type alias Model =
    { elevation : Int
    , mouseOver : Bool
    , size : (String, String)
    , angle : Int
    , isRunning : Bool}


type Action = MouseOver | MouseOut | MouseClick | Resize (Int, Int) | NoOp | Tick Time | ToggleRunning Bool

init : (Model, Effects Action)
init =
    ( { elevation = 2
      , mouseOver = False
      , size = ("800", "600")
      , angle = 0
      , isRunning = True }

    , Effects.task <| (Signal.send resizeInbox.address Nothing) `Task.andThen` (\_ -> Task.succeed (Tick 0)))

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        MouseOver -> ({model| elevation=2, mouseOver=False}, Effects.none)
        MouseOut ->  ({model| elevation=2, mouseOver=False}, Effects.none)
        MouseClick ->  ({model| elevation=8, mouseOver=True}, Effects.none)
        Resize (w,h) -> ({model| size =(dp w, dp (h-4)), mouseOver=False}, Effects.none)
        NoOp -> (model, Effects.none)
        Tick clockTime -> if model.isRunning then ({model|angle = model.angle+1}, Effects.tick Tick) else (model, Effects.none)
        ToggleRunning bool -> if bool then ({model| isRunning = not model.isRunning}, Effects.tick Tick) else (model, Effects.none)

app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs =
        [ Signal.map2 (\a b -> Resize b) resizeInbox.signal (Window.dimensions)
        , Signal.map ToggleRunning  Keyboard.space]
    }

resizeInbox : Signal.Mailbox (Maybe Int)
resizeInbox = Signal.mailbox Nothing


main : Signal Svg
main =  app.html

port tasks : Signal (Task Never ())
port tasks = app.tasks

port title : String
port title = "Elevation Test Page"
