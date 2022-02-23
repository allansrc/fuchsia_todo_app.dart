# fuchsia_todp_app.dart

a fuchsia flutter app 

 Runs through a simple usage of the fuchsia_remote_debug_protocol library:
 connects to a remote machine at the address in argument 1 (interface
 optional for argument 2) to drive an application named 'todo_list' by
 scrolling up and down on the main scaffold.

 Make sure to set up your application (you can change the name from
 'todo_list') follows the setup for testing with the flutter driver:
 https://flutter.io/testing/#adding-the-flutter_driver-dependency

 Example usage:

 $ dart examples/driver_todo_list_scroll.dart \
     fe80::8eae:4cff:fef4:9247 eno1
