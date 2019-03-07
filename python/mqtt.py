import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    client.connect("#")
    print("Connected with result code "+str(rc))
    client.subscribe("$SYS/#")

def on_message(client, userdata, msg):
    print(msg.topic+" "+str(msg.payload))

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect("m16.cloudmqtt.com", 17551, 60)

client.loop_forever()

