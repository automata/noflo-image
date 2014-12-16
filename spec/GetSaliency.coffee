noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  GetSaliency = require '../components/GetSaliency-node.coffee'
  testutils = require './testutils'
else
  GetSaliency = require 'noflo-image/components/GetSaliency.js'
  testutils = require 'noflo-image/spec/testutils.js'
 
 
describe 'GetSaliency component', ->
 
  c = null
  inImage = null
  outPolygon = null

  beforeEach ->
    c = GetSaliency.getComponent()
    inImage = noflo.internalSocket.createSocket()
    outPolygon = noflo.internalSocket.createSocket()
    c.inPorts.canvas.attach inImage
    c.outPorts.polygon.attach outPolygon
 
  describe 'when instantiated', ->
    it 'should have one input port', ->
      chai.expect(c.inPorts.canvas).to.be.an 'object'
    it 'should have one output port', ->
      chai.expect(c.outPorts.polygon).to.be.an 'object'
 
  describe 'with file system image', ->
    it 'should extract a salient polygon', (done) ->
      @timeout 10000
      id = null
      groups = []
      outPolygon.once 'begingroup', (group) ->
        groups.push group
      outPolygon.once 'data', (res) ->
        chai.expect(res).to.be.an 'object'
        # TODO: Check if it extracted the right polygon
        done()

      inSrc = 'textRegion/3010029968_02742a1aec_b.jpg'
      id = testutils.getCanvasWithImageNoShift inSrc, (image) ->
        inImage.beginGroup id
        inImage.send image
        inImage.endGroup()