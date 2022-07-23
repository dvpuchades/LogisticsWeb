import { StatusBar } from 'expo-status-bar';
import { StyleSheet, View } from 'react-native';
import { ApplicationProvider, Layout, Card, Text, Icon, IconRegistry } from '@ui-kitten/components';
import * as eva from '@eva-design/eva';
import { MapPin } from "react-native-feather";

export default function App() {
  return (
    <ApplicationProvider {...eva} theme={eva.light}>
    <Text category='h1' style={{margin: 50}}>Deliveries</Text>
    <Layout style={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
        <Card style={{width: '80%'}}>
          <View style={{flexDirection: 'row'}}>
            <View style={ {flexDirection: 'column', flex: 1} }>
              <MapPin stroke="black" style={{ alignSelf: 'center',marginBottom: 10}}/>
              <Text category='c2' style={{ textAlign: 'center'}}>33£</Text>
            </View>
            <View style={ {flexDirection: 'column', flex: 5, alignItems: 'flex-end'} }>
              <Text category='c2'>21 Tigermilk St</Text>
              <Text category='c2'>San Francisco, CA</Text>
              <Text category='c2'>Shirley Conran</Text>
            </View>
          </View>
        </Card>
    </Layout>
    </ApplicationProvider>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
