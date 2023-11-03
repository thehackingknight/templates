import { getHeaderTitle } from "@react-navigation/elements";
import React from "react";
import { Appbar, Menu } from "react-native-paper";

export const TuAppbar = ({ route, options }) => {

    const [visible, setVisible] = React.useState(false);
  const openMenu = () => setVisible(true);
  const closeMenu = () => setVisible(false);
  
    const title = getHeaderTitle(options, route.name);
    return (
        <Appbar.Header>
            <Appbar.Content title={title} />
            <Menu
          visible={visible}
          onDismiss={closeMenu}
          anchor={
            <Appbar.Action
              icon="dots-vertical"
              onPress={openMenu}
            />
          }>
          <Menu.Item
            onPress={() => {
              console.log('Option 1 was pressed');
            }}
            title="Option 1"
          />
          <Menu.Item
            onPress={() => {
              console.log('Option 2 was pressed');
            }}
            title="Option 2"
          />
          <Menu.Item
            onPress={() => {
              console.log('Option 3 was pressed');
            }}
            title="Option 3"
            disabled
          />
        </Menu>
        </Appbar.Header>
    );
};
