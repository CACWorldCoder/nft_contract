// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract CGS is ERC721URIStorage{

  uint public counter;
  address private _owner;

  constructor() ERC721("CACWORLD-GOODS", "CGS"){
    counter = 0;
    _owner = msg.sender;
  }

  function createNFTs (string memory tokenURI) public onlyOwner returns(uint) {
    uint tokenId = counter;

    _safeMint(msg.sender, tokenId);
    _setTokenURI(tokenId, tokenURI);

    counter ++;
    return tokenId;
  }

  function updateNFTs (uint tokenId, string memory tokenURI) public onlyOwner returns(uint) {
    _setTokenURI(tokenId, tokenURI);
    return tokenId;
  }


  function burn(uint256 tokenId) public virtual {
    require(_isApprovedOrOwner(msg.sender, tokenId), "You can not burn it, because you are not the NFT holder!");
    super._burn(tokenId);
  }

  function owner() public view virtual returns (address) {
    return _owner;
  }

  function transferOwnership(address newOwner) public virtual onlyOwner {
      require(newOwner != address(0), "Ownable: new owner is the zero address");
      _owner = newOwner;
  }

  modifier onlyOwner() {
    require(owner() == msg.sender, "Ownable: caller is not the owner");
    _;
  }

}
