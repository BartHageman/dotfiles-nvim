local ls = require "luasnip"

local s, i, t, c, f = ls.s, ls.insert_node, ls.text_node, ls.choice_node, ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets(nil, {
    -- ls.parser.parse_snippet("triggertext", "snippet" )
    all = {
        -- Available in any filetype
    },
    lua = {
        ls.parser.parse_snippet("lf", "local $1 = function($2)\n $0 \nend"),
        ls.parser.parse_snippet("mf", "$1.$2= function($3)\n $0 \nend"),
        ls.parser.parse_snippet("req", "local $1 = require(\'$1\')")
    },

    papyrus = {
        -- Papyrus snippets
        ls.parser.parse_snippet("eve", "Event $1($2)\n  $3\nEndEvent\n$0"),
        -- ls.parser.parse_snippet("if", "If ($2)\n  $3\nEndIf\n$0"),
        s("if", fmt([[
        If ({}) 
        {}
        EndIf
        {}
        ]], {
        i(1, "condition"),
        i(2),
        i(0, "")
        })),
        ls.parser.parse_snippet("for", "int i = $1\nWhile (i < $2)\n  $3\n  i += $4\nEndWhile\n"),
        ls.parser.parse_snippet("grp", "Group $1\n  $3\nEndGroup\n$0"),
        ls.parser.parse_snippet("prop", "$1 Property $2 Auto Const\n$0"),
        -- ls.parser.parse_snippet("func", "Function $1($2)\n  $3\nEndFunction\n$0"),
        s("func", fmt([[
            {}Function {}({})
                {}
            EndFunction
            {}
        ]],
        {
            c(1, {i(nil,"ReturnType "), t("")}),
            i(2, "FunctionName"),
            i(3, ""),
            i(4),
            i(0)
        })),
        -- ls.parser.parse_snippet("state", "State $1\n  $3\nEndState\n$0"),
        s("state", fmt([[
            State {}
                {}
                {}
                {}
            EndState]],
            {i(1),
            c(
                2,
                {t({"Event OnBeginState(string asOldState)","        ", "    EndEvent"}) , t("")}
            ),
            i(3),
            c(
                4,
                {t({"Event OnEndState(string asNewState)","        ", "    EndEvent"}) , t("")}

            ),
            }
        )),
        ls.parser.parse_snippet("play", "Game.GetPlayer()"),
        ls.parser.parse_snippet("newinputlayer", "InputEnableLayer ${1:LayerName} = InputEnableLayer.Create()"),
        ls.parser.parse_snippet("inputenable", "${1:LayerName}.EnablePlayerControls(${2:abMovement},${3:abFighting},${4:abCamSwitch},${5:abLooking},${6:abSneaking},${7:abMenu},${8:abActivate},${9:abJournalTabs},${10:abVATS},${11:abFavorites},${12:abRunning})"),
        ls.parser.parse_snippet("inputdisable", "${1:LayerName}.DisablePlayerControls(${2:abMovement},${3:abFighting},${4:abCamSwitch},${5:abLooking},${6:abSneaking},${7:abMenu},${8:abActivate},${9:abJournalTabs},${10:abVATS},${11:abFavorites},${12:abRunning})"),
        ls.parser.parse_snippet("inputonlylook", "${1:LayerName}.DisablePlayerControls(true,true,true,false,true,true,true,true,true,true,true)"),
        ls.parser.parse_snippet("delinputlayer", "$1.EnablePlayerControls(true,true,true,true,true,true,true,true,true,true,true)\n$1.Delete()"),
        ls.parser.parse_snippet("strct", "Struct $1\n  $3\nEndStruct\n$0"),
        ls.parser.parse_snippet("magiceffect", "Event OnEffectStart(Actor akTarget, Actor akCaster)\n   \nEndEvent\n\nEvent OnEffectFinish(Actor akTarget, Actor akCaster)\n   \nEndEvent$0")
    },
})
