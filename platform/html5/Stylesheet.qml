Object {
	constructor: {
		var context = this._context
		var options = context.options

		var style = this.style = context.createElement('style')
		style.dom.type = 'text/css'

		this.prefix = options.prefix
		var divId = options.id

		var div = document.getElementById(context, divId)
		var topLevel = div === null

		var userSelect = window.Modernizr.prefixedCSS('user-select') + ": none; "
		var os = _globals.core.os
		var tapHighlightedPlatform = (os === "android" || os === "androidttk" || os === "hisense" || os == "ekt" || os == "sagem")

		//var textAdjust = window.Modernizr.prefixedCSS('text-size-adjust') + ": 100%; "
		style.setHtml(
			//"html { " + textAdjust + " }" +
			"div#" + divId + " { position: absolute; visibility: hidden; left: 0px; top: 0px; }" +
			(os === "webOS" || tapHighlightedPlatform ? this.mangleRule('div', "{ " + userSelect + " }") : "") +
			(tapHighlightedPlatform ? this.mangleRule('div', "{ -webkit-tap-highlight-color: rgba(255, 255, 255, 0); -webkit-focus-ring-color: rgba(255, 255, 255, 0); outline: none; }") : "") +
			(topLevel? "body { padding: 0; margin: 0; border: 0px; overflow: hidden; }": "") + //fixme: do we need style here in non-top-level mode?
			this.mangleRule('video', "{ position: absolute; }") + //fixme: do we need position rule if it's item?
			this.mangleRule('img', "{ position: absolute; -webkit-touch-callout: none; " + userSelect + " }")
		)
		var head = _globals.html5.html.getElement(context, 'head')
		head.append(style)
		head.updateStyle()

		this._addRule = _globals.html5.html.createAddRule(style.dom).bind(this)
		this._lastId = 0
	}

	function allocateClass(prefix) {
		var globalPrefix = this.prefix
		return (globalPrefix? globalPrefix: '') + prefix + '-' + this._lastId++
	}

	function mangleSelector(selector) {
		var prefix = this.prefix
		if (prefix)
			return selector + '.' + prefix + 'core-item'
		else
			return selector
	}

	function mangleRule(selector, rule) {
		return this.mangleSelector(selector) + ' ' + rule + ' '
	}

	function addRule(selector, rule) {
		this._addRule(selector, rule)
	}

}
