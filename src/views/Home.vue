<script>
import * as fcl from "@onflow/fcl"
import * as t from "@onflow/types"

fcl.config()
  .put("accessNode.api", "https://access-testnet.onflow.org")
  .put("challenge.handshake", "https://fcl-discovery.onflow.org/testnet/authn")
  .put("OxProfile", "Oxba1132be8Bf82fe2")
  .put("accessNode.api", process.env.VUE_APP_ACCESS_NODE)
  .put("challenge.handshake", process.env.VUE_APP_WALLET_DISCOVERY)
  .put("0xProfile", process.env.VUE_APP_CONTRACT_PROFILE)

const profile = undefined

const script = fcl.script`
      import Profile from OxProfile

      pub fun main(address: Address): Profile.ReadOnly? {
        return Profile.read(address)
      }
  `

const args = fcl.args([
  fcl.arg(profile?.value?.addr, t.Address)
])

function send() {
  fcl.send([script, args]).then(async (result) => console.log(await fcl.decode(result)))
}

function login() {
  fcl.logIn()
}

function logout() {
  fcl.unauthenticate()
}

fcl.currentUser().subscribe(setUser)

function setUser(user) {
  console.log(user)
  profile.value = user
}

/* function send() {
  fcl.send([
    fcl.script`
      
    `,
    fcl.proposer(fcl.authz),
    fcl.authorizations([fcl.authz]),
    fcl.payer(fcl.authz),
  ])
} */

export default {
  methods: {
    login,
    logout,
    send
  }
}

</script>

<template>
  <div class="bg-gray-50">
    <div
      class="max-w-screen-xl px-4 py-12 mx-auto sm:px-6 lg:py-16 lg:px-8 lg:flex lg:items-center lg:justify-between"
    >
      <div class="flex mt-8 lg:flex-shrink-0 lg:mt-0">
        <button @click="login">Login</button>
        <button class="ml-4 bg-green-300 px-4" @click="send">Send</button>
      </div>
      <button @click="logout">Log Out</button>
    </div>
  </div>
</template>
