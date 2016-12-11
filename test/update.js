var assert = require('assert')
var sinon = require('sinon')
var Model = require('./model.js')
var View = require('./view.js')

describe('ModelUpdate', function() {
	describe('untouched model', function() {
		it('should set single insert range', function() {
			model = new Model()
			view = new View()
			mock = sinon.mock(view)
			mock.expects('_insertItems').once().withArgs(0, 6000)
			model.reset(6000)
			view.length(6000)
			model.apply(view)
		})
	})

	describe('sequental insert', function() {
		it('should set single insert range', function() {
			model = new Model()
			view = new View()
			mock = sinon.mock(view)
			mock.expects('_insertItems').once().withArgs(0, 10)
			for(var i = 0; i < 10; ++i)
				model.insert(0, 1)
			view.length(10)
			model.apply(view)
		})
	})
})