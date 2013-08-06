# HTML input char-counter plugin, written in vanillajs
# miroslav.trninic@gmail.com
do($)->
    #plugin ad object literal
    @superTextArea = 
        init:(options)->
            @cacheElements(options)
            #enable desired functionality inside plugin
            superTextArea.counter.init()
            superTextArea.style.init()

        cacheElements: (options)->
            @tArea= options.tArea 
            @counterSpan= options.counterSpan
            @bgColor= options.bgColor
            @textColor= options.textColor
            @fontFamily= options.fontFamily
            @fontSize= options.fontSize
        

    # counter at the end of textarea
    superTextArea.counter = 
        init: ()->
           @.bindEvents()
        bindEvents:()->
            superTextArea.tArea.on "keydown",(e)=>
                @.count(e)
            superTextArea.tArea.on "focus",(e)->
                e.target.placeholder = ""
            superTextArea.tArea.on "blur",(e)->
                e.target.placeholder = "Enter your text"

        fwd: (e)->
            if e.target.value.length < 255
                superTextArea.counterSpan.text(255 - ( e.target.value.length + 1 ) + " characters left") 
            else
                superTextArea.counterSpan.text(255 -  ( e.target.value.length ) + " characters left")

        back: (e)->
            if e.keyCode is 8
                if e.target.value.length > 0
                    superTextArea.counterSpan.text(255 - ( --e.target.value.length ) + " characters left")
                else
                    superTextArea.counterSpan.text("255 characters left")

        count: (e)->
            @fwd(e)
            @back(e)
            if e.keyCode is 13
                alert(e.target.value)
                superTextArea.counterSpan.text("255 characters left")            
                e.preventDefault()
                e.target.value = ""

    # custom styling
    superTextArea.style = 
        init: ()->
            @.bindEvents()
        bindEvents: ()->
            superTextArea.bgColor.on "click",(e)->
                superTextArea.tArea.css({"backgroundColor": e.target.value})
            superTextArea.textColor.on "click",(e)->
                superTextArea.tArea.css({"color": e.target.value})
            superTextArea.fontFamily.on "click",(e)->
                superTextArea.tArea.css({"fontFamily": e.target.value})
            superTextArea.fontSize.on "click",(e)->
                superTextArea.tArea.css({"fontSize": e.target.value})

    pluginName = "superTextArea"

    defaults =
        tArea:$("textarea")
        counterSpan:$("span")
        bgColor:$("select#bg-color")
        textColor:$("select#text-color")
        fontFamily:$("select#font-family")
        fontSize:$("select#font-size")

    $.fn[pluginName] = (custom)->
        if typeof custom != "undefined"
            superTextArea.init(custom)
            @
        else
            superTextArea.init(defaults)
            @

    # plugin is called on a document.body object, with a custom selected elements
    $(document.body).superTextArea()









 








    

