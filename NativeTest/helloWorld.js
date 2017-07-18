import React, { Component } from 'react';
import { AppRegistry, View, Text} from 'react-native';

class HelloWorldCp extends Component {
    render() {
        return (
            <View style={{flex:1 , justifyContent: 'center', alignItems: 'center'}}>
              <Text>Hello world!</Text>
            </View>
        );
    }
}

AppRegistry.registerComponent('HelloWorldCp', () => HelloWorldCp);
