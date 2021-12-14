import HockeyContract from 0xf8d6e0586b0a20c7

transaction {
  let receiverRef: &{HockeyContract.NFTReceiver}
  let minterRef: &HockeyContract.NFTMinter

  prepare(acct: AuthAccount) {
      self.receiverRef = acct.getCapability<&{HockeyContract.NFTReceiver}>(/public/NFTReceiver)
          .borrow()
          ?? panic("Could not borrow receiver reference")        
      
      self.minterRef = acct.borrow<&HockeyContract.NFTMinter>(from: /storage/NFTMinter)
          ?? panic("could not borrow minter reference")
  }

  execute {
      let metadata : {String : String} = {
          "name": "The Big Swannggg",
          "swing_velocity": "29", 
          "swing_angle": "45", 
          "rating": "5",
          "uri": "ipfs://QmPJRsBTxNAKSC5EKn9hpRpz6jE8AfqXRSxZGHxoqhG8CK"
      }
      let newNFT <- self.minterRef.mintNFT()
  
      self.receiverRef.deposit(token: <-newNFT, metadata: metadata)

      log("NFT Minted and deposited to Account 2's Collection")
  }
}