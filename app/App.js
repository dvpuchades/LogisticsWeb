import { StyleSheet, Text, View } from 'react-native';
import React, { Component } from 'react';
import { SwipeListView } from 'react-native-swipe-list-view';

export default function App() {
  return (
    <View style={styles.container}>
      <List/>
    </View>
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

class List extends Component {
  render() {
    return (
      <SwipeListView
          data={[{key: '1', text: 'hi'},{key: '2', text: 'h3llo'}, {key: '3', text: 'morning'}, {key: '4', text: 'good'}]}
          renderItem={ (data, rowMap) => (
              <View style={styles.rowFront}>
                  <Text>I am {data.item.text} in a SwipeListView</Text>
              </View>
          )}
          renderHiddenItem={ (data, rowMap) => (
              <View style={styles.rowBack}>
                  <Text>Left</Text>
                  <Text>Right</Text>
              </View>
          )}
          leftOpenValue={75}
          rightOpenValue={-75}
      />
    );
  }
}