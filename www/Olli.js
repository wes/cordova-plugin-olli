var argscheck = require('cordova/argscheck'),
    channel = require('cordova/channel'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec'),
    cordova = require('cordova');

 function Olli() {

    this.connCallback = null;
    this.errorCallback = null;
    this.cancelCallback = null;
    this.cardDataCallback = null;
    this.barcodeCallback = null;

}

Olli.prototype.initOlli = function(connectionCallback, cardCallback, barcCallback, cancelCallback, errorCallback) {

    this.connCallback = connectionCallback;
    this.cardDataCallback = cardCallback;
    this.barcodeCallback = barcCallback;

    exec(null, errorCallback, 'Olli', 'initOlli', []);
};

Olli.prototype.startScan = function() {
    exec(null, null, 'Olli', 'startScan', []);
};

Olli.prototype.connectionChanged = function(state) {
    this.connCallback(state);
};

Olli.prototype.onMagneticCardData = function(track1, track2, track3) {
    this.cardDataCallback(track1 + track2 + track3);
};

Olli.prototype.onBarcodeData = function(barcode_data) {
    this.barcodeCallback(barcode_data);
};

module.exports = new Olli();
