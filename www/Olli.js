var argscheck = require('cordova/argscheck'),
    channel = require('cordova/channel'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec'),
    cordova = require('cordova');

 function Olli() {
    this.results = [];

    this.connCallback = null;
    this.errorCallback = null;
    this.cancelCallback = null;
    this.cardDataCallback = null;
    this.barcodeCallback = null;

    // this.btDiscoveryCompleteCallback = null;
    // this.btConnectedCallback = null;
    // this.btDisconnectedCallback = null;
    // this.btGetDeviceNameCallback = null;

}

Olli.prototype.initOlli = function(connectionCallback, cardCallback, barcCallback, cancelCallback, errorCallback, btDiscCallback, btConnCallback, btDisconnCallback, btGetDeviceNameCallback) {
    this.results = [];

    this.connCallback = connectionCallback;
    this.cardDataCallback = cardCallback;
    this.barcodeCallback = barcCallback;

    // this.btDiscoveryCompleteCallback = btDiscCallback;
    // this.btConnectedCallback = btConnCallback;
    // this.btDisconnectedCallback = btDisconnCallback;

    exec(null, errorCallback, "Olli", "initDT", []);
    //alert("Olli");
};

Olli.prototype.barcodeStart = function() {
    exec(null, null, "Olli", "startBarcode", []);
};

Olli.prototype.barcodeStop = function() {
    exec(null, null, "Olli", "stopBarcode", []);
};

Olli.prototype.connectionChanged = function(state) {
    this.connCallback(state);
};

Olli.prototype.onMagneticCardData = function(track1, track2, track3) {
    this.cardDataCallback(track1 + track2 + track3);
    //this.barcodeStart();
};

// Olli.prototype.discoverDevices = function() {
//     exec(null, null, "Olli", "discoverDevices", []);
// }
// 
// Olli.prototype.setPassThroughSync = function() {
//     exec(null, null, "Olli", "setPassThroughSync", []);
// }
// 
// Olli.prototype.unsetPassThroughSync = function() {
//     exec(null, null, "Olli", "unsetPassThroughSync", []);
// }
// 
// Olli.prototype.btConnect = function(address) {
//     exec(null, null, "Olli", "btConnect", [address]);
// }
// 
// Olli.prototype.btDisconnect = function(address) {
//     exec(null, null, "Olli", "btDisconnect", [address]);
// }
// 
// Olli.prototype.btWrite = function(data) {
//     exec(null, null, "Olli", "btWrite", [data]);
// }
// 
// Olli.prototype.prnPrintText = function(data) {
//     exec(null, null, "Olli", "prnPrintText", [data]);
// }
// 
// Olli.prototype.prnPrintZPL = function(data) {
//     exec(null, null, "Olli", "prnPrintZPL", [data]);
// }

Olli.prototype.onBarcodeData = function(rawCodesArr, scanId, dob, state, city, expires, gender, height, weight, hair, eye, firstName, lastName) {
    var data = {
               rawCodesArr: rawCodesArr,
               scanId: scanId,
               dob: dob,
               state: state,
               city: city,
               expires: expires,
               gender: gender,
               height: height,
               weight: weight,
               hair: hair,
               eye: eye,
               firstName: firstName,
               lastName: lastName
               };
    this.barcodeCallback(data);
};

// Olli.prototype.onBluetoothDeviceConnected = function(address, error) {
//   this.btConnectedCallback(address, error);
// }
// 
// Olli.prototype.onBluetoothDeviceDisconnected = function(address) {
//   this.btDisconnectedCallback(address);
// }
// 
// Olli.prototype.onBluetoothDiscoverComplete = function(success, devices, error) {
//   this.btDiscoveryCompleteCallback( (success===1) , devices, error);
// }
// 
// Olli.prototype.onBluetoothGetDeviceName = function(address, name) {
//   this.btGetDeviceNameCallback(address, name);
// }

module.exports = new Olli();
