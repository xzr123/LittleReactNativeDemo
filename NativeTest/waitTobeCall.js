import React, { Component } from 'react';
import { AppRegistry, View, Text,NativeModules,NativeEventEmitter,TouchableHighlight} from 'react-native';

var CallRNTest = NativeModules.CallRNTest;
const myNativeEvt = new NativeEventEmitter(CallRNTest);

class BeCalledCp extends Component {
    render() {
        return (
            <View style={{flex:1 , flexDirection:'row' , justifyContent: 'center', alignItems: 'center'}}>
                
                <TouchableHighlight onPress={()=>CallRNTest.callMe()}>
                    <Text>ready to be called!</Text>
                </TouchableHighlight>
                
            </View>
        );
    }
    
    componentWillMount() {
        this.listener = myNativeEvt.addListener('callRn', this.callRn.bind(this));  //对应了原生端的名字
    }
    
    componentWillUnmount() {
        this.listener && this.listener.remove();  //记得remove哦
        this.listener = null;
    }
    
    callRn(data) {//接受原生传过来的数据 data={code:,result:}
        console.warn(data.code, data.result);
//        if (data.code == '200') {
//            //
//            console.log(data.result);
//        }
//        else {//..真的是未知的错误
//            console.warn('err',data.result);
//        }  
    }
}

AppRegistry.registerComponent('BeCalledCp', () => BeCalledCp);
