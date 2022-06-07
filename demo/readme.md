# Demo: Sensor Model Tokenization and Access Management
This demo shows the traceability of a sensor model as a tokenized data set on a public blockchain as well as a possible way to handle access management and data hand over from the Tier 1 to the OEM. This is achieved through using established blockchain token standards (TZIP) and JSON web tokens. The token standards are extended in a layered approach through the usage of automotive domain specific standards from [ASAM e.V.](https://www.asam.net/) and other public research projects like [SETLevel](https://setlevel.de/).

Key words:
* traceability
* sensor model
* token standards (TZIP)
* Cross supplier 
* Common trusted settlement layer

## Technical components and demonstration purpose

The document sketches a possible story-line on how to use a public blockchain infrastructure (like the Tezos open source technology stack and public node infrastructure), an open cloud storage infrastructure (IPFS), community provided tools (libraries, wallets, block explorers), open standard specifications (TZIP) and automotive/IT domain specific standards (ASAM, FMI, etc). The demonstration purpose is primarily to show the interplay of these lose components and in general how to benefit from the network effects of a world wide open source community. Secondly it shows how to seamlessly integrate with existing blockchain standards and how to complement them with domain-specific requirements and standards. At last it should encourage the discussion on design choices and requirements for our specific use case and domain at the example of running software.

## GaiaX Vision
"We want to create a decentralized open data ecosystem for standardized simulation data used to validate L3+ automated driving functions"

The ecosystem should satisfy the following attributes:
* Accessible
* Non discriminating
* Decentralized
* Distributed
* Open source
* No vendor lock in
* Active OS community
* Actively used and proven tech stack
* Perceptive and used to change (working Change Management Process)

## Current Situation
A central marketplace without or with custom bridges to other marketplaces using email and password as login method like the [ASC(S e.V. ENVITED Marketplace](https://envited.market/). But what we seek is rather a "window into an ecosystem" comparable to a search engine showing results of different marketplaces compared to a central one.

Requirements:
* User based access with possibly additional requirements like "be a member of the ASC(S e.V."
* Not all data must be available but protected by a fine grained access management "you only see this meta data if XY"
* Interconnect other marketplaces and data sources
* Build on an open architecture

## NFT Marketplaces
In order to profit from existing solutions let us have a look into the world of digital art with the keyword "NFTs". There are different marketplaces that all use [Tezos](https://tezos.com/) as a base technology layer and the art is "tokenized" using a specific TZIP standard (FA2 Standard). There are:

* Community driven and open source marketplaces like [Teia](https://teia.art/)
* Closed source commercial marketplaces like [Versum](https://versum.xyz/)
* Aggregating marketplace showing all others including their own pieces like [Objkt.com](https://objkt.com/asset/hicetnunc/133414)

Take-away:
* Decentralized login using the "private key" through signing an "individual sign in message"
* User is primarily identified with the "public key hash", our non-forgeable break point in the system
* [tzprofiles](https://tzprofiles.com/) as one example for a [DID](https://www.w3.org/TR/did-core/) extension to add user details
* Common token and smart contract interfaces through the [TZIP Standards](https://gitlab.com/tezos/tzip/-/tree/master)

## Sensor Model Tokenization Demo
### General
We use a fork of [Sign In With Tezos](https://github.com/StakeNow/SIWT) a library that supports the development of a decentralized application (dApp) by

* proving the users ownership of the private key to the address the user signs in with,
* adding permissions to use your API or FrontEnd based on the ownership of a Non-Fungible Token (NFT).

Follow the [instructions](https://github.com/AlgedonicLoop/SMSIWTDemo#run-the-demo) to run it [locally](http://localhost:8080) or have a look at the [deployed version](nftdemo.algedonicloop.io/). The demo uses the following core components:

* [Beacon](https://www.walletbeacon.io/) to connect a wallet
* [Temple](https://templewallet.com/) as an example wallet (can be replaced by any other)
* [JSON Web Token](https://jwt.io/), a widely used industry standard

### Demo Content
The demo shows the communication of a front end with a web server where a user requests different kind of information:

* Free Content: There is no restriction on the data which is represented by the response message
* Basic Content: You need to "connect" and prove your identity by signing a message. Through clicking the "basic content" button the user will be authenticated by the server through the previously received jwt token and trigger a file download including (restricted) Sensor Model meta data from the server
* Premium Content: To access this content you need to possess a specific NFT in your (blockchain) account to access the data which is the Sensor Model the previously accessed meta data belongs to packaged as a FMU

Create an account "Alice" on the public Tezos test network "Ithacanet" to get "Basic Content". A second user "Bob" would need the special NFT as it can be seen in this [account](https://ithacanet.tzkt.io/tz1dRpub3dju9nsNDYgRMkfS5yPvkpZe4BPj/balances) - contact Pierre Mai to get an access NFT for test purposes.

Take-away:
* Use existing industry standards like JWT for access tokens
* Couple the creation of those tokens to conditions like "proof private key ownership" to facilitate blockchain technology
* Signing a message does not require a blockchain transaction
* Let the idea of using NFTs for fine grained access management sink in
* A wallet is just a piece of software that can be replaced but the interaction and architecture of components is interesting: beacon SDK to connect to wallet, JWT access library -> Divide and Conquer

## The "Layered Standards Approach"
Now we need to dive into the details of what existing standards have been used in this example. Our entry point is the NFT. The token is minted through a specific [token contract](https://ithacanet.tzkt.io/KT1UhBEM4AUaQ13sWqLKBL4o7HAc8D7zMzjK/storage/104313). If you investigate the storage -> metadata in the link you will find the key "content" which contains the metadata of the contract. Besides basic information like "name" and "description" you see the following "interfaces":
* [TZIP-12](https://gitlab.com/tezos/tzip/-/blob/master/proposals/tzip-12/tzip-12.md) proposes a standard for a unified token contract interface, supporting a wide range of token types and implementations. This document provides an overview of the interface, token transfer semantics, and metadata
* [TZIP-16](https://gitlab.com/tezos/tzip/-/blob/master/proposals/tzip-16/tzip-16.md) extends the contract interface with the necessary contract meta data providing information that is not directly used for a contract's operation, whether about the contract's code (e.g. its interface, versioning) or the off-chain meaning of its contents (e.g. an artwork
corresponding to an NFT)
* [TZIP-21](https://gitlab.com/tezos/tzip/-/blob/master/proposals/tzip-21/tzip-21.md) ia another extension describing a metadata schema and standards for contracts and tokens. The document is broken into two main sections: 1) The metadata schema, and 2) standards and recommendations for how to apply the schema to different token types. Many of the terms in this standard are derived from The Dublin Core, RCF 2413.

Investigating the [token metadata](https://ipfs.io/ipfs/QmZu1fHWhoiLhzC5rt8HzvB63W4XGZ7tCc54suurmb7fPW) it becomes apparent that the existing fields can be used to host all necessary information to let the token represent not only a piece of art of e.g. mimetype "image/jpeg" but also data of type "application/x-fmu-sharedlibrary" which is the type of the "artifactUri" pointing to a [standardized Sensor Model](https://github.com/OpenSimulationInterface/open-simulation-interface) packaged as a Functional Mockup Unit (FMU) defined in [OSI Sensor Model Packaging](https://github.com/OpenSimulationInterface/osi-sensor-model-packaging) using the industry standard [FMI](https://fmi-standard.org/). The field "attributes" is exemplary used to further detail the information about the artifact in XML and [JSON](https://ipfs.io/ipfs/QmT5NF9okpurrSoFTYVkjHNj8voF67TbTxqiFuceRL24mr) format. The meta data is not arbitrary but has been worked on in the research project SETLevel and is defined as [Simulation Resource Meta Data (SRMD)](https://gitlab.setlevel.de/open/processes_and_traceability/traceability_data/-/tree/main/metadata_format_for_models). The SRMD file format specification is part of the [SSP Traceability](https://github.com/PMSFIT/SSPTraceability) draft specification being worked on, which is an [SSP-based](https://ssp-standard.org/) layered standard for simulation traceability information exchange.

Take-away:
* We use TZIP standards of another domain and extend them cleverly with domain specific standards
* This allows us the use of existing tooling like block explorers and wallets
* All standards build upon each other and are independently useful and applicable in different domains, their combination and inter-chaining is key

## Possible tasks
Now we can ask ourself which information represented by the different layers of meta data should be stored where and accessible under which conditions. Do we want to apply encryption and on which platform do we want to store the data (here e.g. IPFS and a private web server). Which information should be traceable through the global layer (blockchain) and which should not. A possible task would be to define the signing message standard as [TZIP](https://gitlab.com/tezos/tzip/-/merge_requests/183/diffs) as already started. In addition we can ask what kind of technological features a base layer technology like Tezos could need to further refine and extend this use case. The concept of [Tickets](https://www.marigold.dev/post/tickets-for-dummies) is also something to investigate further. The idea to represent a data set as permanent record and NFT can be challenged regarding the question if the access management of the data itself should be handled by the NFT possession.

Finally this should motivate every participant to find himself in this small demo and "take a bite" to resolve a specific issue that has not been resolved. Like associating a DID proof to the public key.
