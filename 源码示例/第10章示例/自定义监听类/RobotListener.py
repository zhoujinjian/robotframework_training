class RobotListener(object):
    ROBOT_LISTENER_API_VERSION = 2

    def start_suite(self, name, args):
        print("Starting Suite : " + name + "  " + args['source'])

    def start_test(self, name, args):
        print("Starting test : " + name)
        if args['template']:
            print('Template is : ' + args['template'])

    def end_test(self, name, args):
        print("Ending test:  " + args['longname'])
        print("Test Result is : " + args['status'])
        print("Test Time is: " + str(args['elapsedtime'])）)

    def log_message(self, message):
        print(message['timestamp'] + " :   " + message['level'] + " : " + message['message'])
