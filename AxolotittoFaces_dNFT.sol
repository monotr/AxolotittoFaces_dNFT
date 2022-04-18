// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AxolotittosFaces is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {

    uint startTime;
    uint totalMints = 10;
    
    string[] private uris = [
        "https://gateway.pinata.cloud/ipfs/QmUr9CyycoqZTU3BpfiQksr5pTtT2UJGdbfiTMQGDRi3Zp/avatar_0.json",
        "https://gateway.pinata.cloud/ipfs/QmUr9CyycoqZTU3BpfiQksr5pTtT2UJGdbfiTMQGDRi3Zp/avatar_1.json",
        "https://gateway.pinata.cloud/ipfs/QmUr9CyycoqZTU3BpfiQksr5pTtT2UJGdbfiTMQGDRi3Zp/avatar_2.json",
        "https://gateway.pinata.cloud/ipfs/QmUr9CyycoqZTU3BpfiQksr5pTtT2UJGdbfiTMQGDRi3Zp/avatar_3.json",
        "https://gateway.pinata.cloud/ipfs/QmUr9CyycoqZTU3BpfiQksr5pTtT2UJGdbfiTMQGDRi3Zp/avatar_4.json",
        "https://gateway.pinata.cloud/ipfs/QmUr9CyycoqZTU3BpfiQksr5pTtT2UJGdbfiTMQGDRi3Zp/avatar_5.json"
    ];

    constructor() ERC721("AxolotittosFaces", "AXTTFC") {
        startTime = block.timestamp + 3600; // 1 hour (+ secs before NFT reveals)

        // mint amount to owner
        for (uint8 i=0; i<totalMints; i++) {
            _safeMint(owner(), i);
        }
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function getCurrentHour() private view returns (uint8) {
        return uint8((block.timestamp / 60 / 60) % 24);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        if (block.timestamp < startTime) {
            return "https://gateway.pinata.cloud/ipfs/QmUr9CyycoqZTU3BpfiQksr5pTtT2UJGdbfiTMQGDRi3Zp/notready.json";
        }

        uint currentHour = getCurrentHour();
        return uris[currentHour / 4];
    }
}