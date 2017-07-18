import React, {Component} from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    NativeModules,
    TouchableHighlight
} from "react-native";

var RNIOSAlert = NativeModules.RNIOSAlert;

class RNIosCallbackCp extends Component {
    _alertCallback() {
        RNIOSAlert.showAlertAndCallback(function (err, data) {
            if (err) {
                console.warn(err, data);
            } else {
                console.warn(data,'无错回调');
            }

        });
    }

    render() {
        return (
            <View style={styles.container}>
            
                <TouchableHighlight
                    style={styles.btn}
                    onPress={()=>this._alertCallback()}>
                    <Text>showAlertCallback</Text>
                </TouchableHighlight>
                
            </View>
        )
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#FFFCFF',
    },
    btn: {
        margin: 10
    },
});

AppRegistry.registerComponent('RNIosCallbackCp', () => RNIosCallbackCp);
