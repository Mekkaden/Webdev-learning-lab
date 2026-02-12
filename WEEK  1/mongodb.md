What $push is (exactly)

$push is a MongoDB update operator.

Its job:

Add a value to an array field inside a document.

That’s it. No magic.




What a cluster is : 

A group of servers

Hosts your databases

Exists for:

scalability

replication

fault tolerance

In Mongo Atlas:

You create one cluster

Everything lives inside it

Think:

Cluster = data center setup


“Model represents a MongoDB collection and provides methods to interact with it.”


Middleware is a function that executes before route handlers to process, validate, or authorize incoming requests.


Think of JWT as:

🎟️ A wristband at a concert

proves you already entered

you don’t re-show ID every time

2️⃣ Token is stored on your phone (quietly)

Instagram app stores this token:

you never see it

you don’t touch it

it just exists

This token contains:

your user ID

expiry time

signature (to prevent tampering)

⚠️ Important:

Token is NOT encrypted

Anyone can read it

But no one can modify it (signature breaks)

3️⃣ Every action sends the token automatically

Now you do normal stuff:

scroll feed

like a post

comment

open profile

follow someone

Every request secretly includes the token

