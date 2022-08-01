import { StatusBar } from 'expo-status-bar';
import { StyleSheet, View } from 'react-native';
import { ApplicationProvider, Layout, Card, Text, Input, Button } from '@ui-kitten/components';
import * as eva from '@eva-design/eva';
import { default as theme } from './theme.json';
import { MapPin } from "react-native-feather";
import * as Linking from 'expo-linking';

export default function App() {
  return loginScreen()
}

function loginScreen(){
  return (
    <ApplicationProvider {...eva} theme={{...eva.light, ...theme}}>
    <Layout style={{flex: 1, flexDirection: 'column', justifyContent: 'center'}}>
    <Text category='h1' style={{marginLeft: 15}}>Log In</Text>
      <View style={{justifyContent: 'center'}}>
          <Input style={{ margin: 15 }} placeholder='Email' />
          <Input style={{ margin: 15 }} placeholder='Password'/>
          <Button style={{ margin: 15 }} onPress={() => {}}>
            Log In
          </Button>
      </View>
    </Layout>
    </ApplicationProvider>
  )
}

function Deliveries() {
  return (
    <ApplicationProvider {...eva} theme={{...eva.light, ...theme}}>
    <Layout>
      <Text category='h1' style={{margin: 50}}>Deliveries</Text>
      <View style={{alignItems: 'center'}}>
        <Card style={{width: '80%'}} onPress={() => {openCoordinates(51.891537285024135, -8.482363359635274)}}>
          <View style={{flexDirection: 'row'}}>
            <View style={ {flexDirection: 'column', flex: 1, justifyContent: 'center'} }>
              <MapPin stroke="black" style={{ alignSelf: 'center', }}/>
            </View>
            <View style={ {flexDirection: 'column', flex: 5, alignItems: 'flex-end'} }>
              <Text category='h6'>21 Tigermilk St</Text>
              <Text category='s1'>San Francisco, CA</Text>
              <Text category='s1'>Shirley Conran, 33€</Text>
            </View>
          </View>
        </Card>
      </View>
    </Layout>
    </ApplicationProvider>
  );
}

function openCoordinates(latitude, longitude) {
  const scheme = Platform.select({ ios: 'maps:0,0?q=', android: 'geo:0,0?q=' });
  const latLng = `${latitude},${longitude}`;
  const url = Platform.select({
    ios: `${scheme}@${latLng}`,
    android: `${scheme}${latLng}`
  });
  Linking.openURL(url);
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
