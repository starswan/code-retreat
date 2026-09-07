module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Random
import Time



-- MODEL


type alias Cell =
    ( Int, Int )


type alias Model =
    { live : List Cell
    , running : Bool
    }


width : Int
width =
    40


height : Int
height =
    25


initialModel : Model
initialModel =
    { live = []
    , running = False
    }



-- MESSAGES


type Msg
    = ToggleCell Int Int
    | Step
    | ToggleRunning
    | Clear
    | Randomize
    | RandomCells (List Cell)



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleCell x y ->
            let
                cell =
                    ( x, y )

                newLive =
                    if List.member cell model.live then
                        List.filter ((/=) cell) model.live

                    else
                        cell :: model.live
            in
            ( { model | live = newLive }, Cmd.none )

        Step ->
            ( { model | live = nextGeneration model.live }, Cmd.none )

        ToggleRunning ->
            ( { model | running = not model.running }, Cmd.none )

        Clear ->
            ( { model | live = [], running = False }, Cmd.none )

        Randomize ->
            ( model, randomCells )

        RandomCells cells ->
            ( { model | live = cells }, Cmd.none )



-- GAME OF LIFE


nextGeneration : List Cell -> List Cell
nextGeneration liveCells =
    let
        candidates =
            liveCells
                |> List.concatMap neighbors
                |> unique

        survives cell =
            let
                count =
                    liveNeighborCount cell liveCells
            in
            List.member cell liveCells
                && (count == 2 || count == 3)

        born cell =
            not (List.member cell liveCells)
                && liveNeighborCount cell liveCells
                == 3
    in
    List.filter (\cell -> survives cell || born cell) candidates
        |> unique


neighbors : Cell -> List Cell
neighbors ( x, y ) =
    [ ( x - 1, y - 1 )
    , ( x, y - 1 )
    , ( x + 1, y - 1 )
    , ( x - 1, y )
    , ( x + 1, y )
    , ( x - 1, y + 1 )
    , ( x, y + 1 )
    , ( x + 1, y + 1 )
    ]
        |> List.filter inBounds


liveNeighborCount : Cell -> List Cell -> Int
liveNeighborCount cell liveCells =
    neighbors cell
        |> List.filter (\neighbor -> List.member neighbor liveCells)
        |> List.length


inBounds : Cell -> Bool
inBounds ( x, y ) =
    x
        >= 0
        && x
        < width
        && y
        >= 0
        && y
        < height


unique : List Cell -> List Cell
unique cells =
    List.foldl
        (\cell result ->
            if List.member cell result then
                result

            else
                cell :: result
        )
        []
        cells



-- RANDOM INITIAL STATE


randomCells : Cmd Msg
randomCells =
    let
        generator =
            Random.list
                (width * height)
                (Random.uniform True [ False, False, False, False ])
    in
    Random.generate
        (\values ->
            values
                |> List.indexedMap
                    (\index alive ->
                        if alive then
                            Just
                                ( modBy width index
                                , index // width
                                )

                        else
                            Nothing
                    )
                |> List.filterMap identity
                |> RandomCells
        )
        generator



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style "font-family" "system-ui, sans-serif"
        , style "max-width" "900px"
        , style "margin" "30px auto"
        , style "padding" "20px"
        ]
        [ div
            [ style "display" "flex"
            , style "justify-content" "space-between"
            , style "align-items" "center"
            , style "margin-bottom" "15px"
            ]
            [ div []
                [ div
                    [ style "font-size" "28px"
                    , style "font-weight" "700"
                    ]
                    [ text "Conway's Game of Life" ]
                , div
                    [ style "color" "#666"
                    , style "margin-top" "5px"
                    ]
                    [ text
                        (String.fromInt (List.length model.live)
                            ++ " living cells"
                        )
                    ]
                ]
            , div
                [ style "font-size" "18px"
                , style "font-weight" "600"
                , style "color"
                    (if model.running then
                        "#16a34a"

                     else
                        "#666"
                    )
                ]
                [ text
                    (if model.running then
                        "● Running"

                     else
                        "● Paused"
                    )
                ]
            ]
        , div
            [ style "display" "flex"
            , style "gap" "8px"
            , style "margin-bottom" "15px"
            , style "flex-wrap" "wrap"
            ]
            [ controlButton
                (if model.running then
                    "Pause"

                 else
                    "Play"
                )
                ToggleRunning
            , controlButton "Step" Step
            , controlButton "Randomize" Randomize
            , controlButton "Clear" Clear
            ]
        , gameBoard model
        , div
            [ style "margin-top" "15px"
            , style "color" "#666"
            , style "font-size" "14px"
            ]
            [ text "Click cells to toggle them. Use Step to advance one generation." ]
        ]


controlButton : String -> Msg -> Html Msg
controlButton label msg =
    button
        [ onClick msg
        , style "border" "none"
        , style "border-radius" "6px"
        , style "padding" "9px 16px"
        , style "background" "#2563eb"
        , style "color" "white"
        , style "font-size" "14px"
        , style "cursor" "pointer"
        ]
        [ text label ]


gameBoard : Model -> Html Msg
gameBoard model =
    div
        [ style "display" "grid"
        , style "grid-template-columns"
            ("repeat(" ++ String.fromInt width ++ ", 1fr)")
        , style "width" "100%"
        , style "aspect-ratio"
            (String.fromInt width ++ "/" ++ String.fromInt height)
        , style "background" "#d1d5db"
        , style "gap" "1px"
        , style "border" "1px solid #9ca3af"
        ]
        (List.range 0 (width * height - 1)
            |> List.map
                (\index ->
                    let
                        x =
                            modBy width index

                        y =
                            index // width

                        alive =
                            List.member ( x, y ) model.live
                    in
                    cellView x y alive
                )
        )


cellView : Int -> Int -> Bool -> Html Msg
cellView x y alive =
    div
        [ onClick (ToggleCell x y)
        , style "background"
            (if alive then
                "#111827"

             else
                "#f9fafb"
            )
        , style "cursor" "pointer"
        ]
        []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.running then
        --Time.every (100 * Time.millisecond) (\_ -> Step)
        Time.every 100 (\_ -> Step)

    else
        Sub.none



-- PROGRAM


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
