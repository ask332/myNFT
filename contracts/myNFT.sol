// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.5.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.5.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.5.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.5.0/utils/Counters.sol";

contract Candy is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256  public mintRate = 0.001 ether;
    constructor() ERC721("Candy", "CDY") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/QmPznf4F2hyqgLNUvT2U9kxuw7dgP4JYXfwvRCQzPjSPxE?filename=Untitled%20design.png";
    }

    function safeMint(address to) public payable{
        require(msg.value >= mintRate, "insufficient balance transferred");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    function withdraw() public onlyOwner {
        require(address(this).balance > 0);  
        payable(owner()).transfer(address(this).balance);
    }
}
