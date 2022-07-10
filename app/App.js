import { StatusBar } from 'expo-status-bar';
import { StyleSheet, View } from 'react-native';
import { ApplicationProvider, Layout, Card, Text, Icon, IconRegistry } from '@ui-kitten/components';
import * as eva from '@eva-design/eva';
import { MapPin } from "react-native-feather";

export default function App() {
  return (
    <ApplicationProvider {...eva} theme={eva.light}>
    <Text category='h1' style={{margin: 50}}>HOME</Text>
    <Layout style={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
        <Card style={{width: '80%'}}>
          <View style={{flexDirection: 'row'}}>
            <MapPin  stroke="black" style={{ marginRight: 15}}/>
            <Text>Hello World</Text>
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
