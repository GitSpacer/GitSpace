//
//  GitHubService.swift
//  GSNetwork
//
//  Created by 박제균 on 2/14/24.
//

import Foundation

final class GitHubService: HTTPClient, GitHubServiceProtocol {

    /**
     인증된 유저의 계정으로 특정 유저를 팔로우합니다.
     - Author: 제균
     - returns: 요청 성공시 성공했다는 string을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestToFollowUser(userName: String) async throws {
        return try await sendRequest(endpoint: GitHubEndpoint.followUser(userName: userName))
    }

    /**
     인증된 유저의 계정으로 특정 유저를 언팔로우합니다.
     - Author: 제균
     - returns: 요청 성공시 성공했다는 string을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestToUnfollowUser(userName: String) async throws {
        return try await sendRequest(endpoint: GitHubEndpoint.unfollowUser(userName: userName))
    }

    /**
     인증된 유저가 특정 유저를 팔로우하는지 여부를 API에 요청합니다.
     - Author: 제균
     - returns: 요청 성공시 성공했다는 string을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestAuthenticatedUserFollowsPerson(userName: String) async throws {
        return try await sendRequest(endpoint: GitHubEndpoint.authenticatedUserFollowsPerson(userName: userName))
    }

    /**
     인증된 유저의 팔로워 목록을 불러옵니다.
     - Author: 제균
     - returns: 요청 성공시 유저 정보 모델을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestAuthenticatedUserFollowers(perPage: Int, page: Int) async -> Result<[FollowerResponse], GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.authenticatedUserFollowers(perPage: 100, page: page))
    }

    /**
     인증된 유저의 정보를 요청합니다.
     - Author: 제균
     - returns: 요청 성공시 유저 정보 모델을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestAuthenticatedUser() async -> Result<GithubUser, GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.authenticatedUserInformation)
    }

    /**
     인증된 유저의 레포지토리 목록를 요청합니다.
     - Author: 제균
     - parameters:
        - page: 요청할 page number
     - returns: 요청 성공시 유저가 권한을 가진 레포지토리 목록을, 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestAuthenticatedUserRepositories(page: Int) async -> Result<[RepositoryResponse], GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.authenticatedUserRepositories(page: page))
    }

    /**
     인증된 유저의 star repositories를 요청합니다.
     - Author: 제균
     - parameters:
        - page: 요청할 page number
     - returns: 요청 성공시 유저가 star를 눌러둔 레포지토리 목록을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestAuthenticatedUserStars(page: Int) async -> Result<[RepositoryResponse], GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.authenticatedUserStarRepositories(page: page))
    }

    /**
     인증된 유저의 received events를 요청합니다.
     - Author: 제균
     - parameters:
        - page: 요청할 page number
     - returns: 요청 성공시 유저가 받은 Event 목록을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestAuthenticatedUserReceivedEvents(userName: String, page: Int) async -> Result<[Event], GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.authenticatedUserReceivedEvents(userName: userName, page: page))
    }

    /**
     인증된 사용자의 계정으로 특정 레포지토리를 star하는 PUT 요청을 보냅니다.
     - Author: 제균
     - parameters:
        - owner: 레포지토리 주인의 userName
        - repositoryName: star를 누를 대상 레포지토리의 이름
     - returns: 요청 성공시 성공했다는 string을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestToStarRepository(owner: String, repositoryName: String) async throws {
        return try await sendRequest(endpoint: GitHubEndpoint.starRepository(owner: owner, repositoryName: repositoryName))
    }

    /**
     인증된 사용자의 계정으로 특정 레포지토리를 star하는 DELETE 요청을 보냅니다.
     - Author: 제균
     - parameters:
        - owner: 레포지토리 주인의 userName
        - repositoryName: star를 해제할 대상 레포지토리의 이름
     - returns: 요청 성공시 성공했다는 string을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestToUnstarRepository(owner: String, repositoryName: String) async throws {
        return try await sendRequest(endpoint: GitHubEndpoint.unstarRepository(owner: owner, repositoryName: repositoryName))
    }

    /**
     특정 유저의 Public 정보를 요청합니다.
     - Author: 제균
     - parameters:
        - userName: GitHub userName
     - returns: 요청 성공시 유저 정보 모델을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestUserInformation(userName: String) async -> Result<GithubUser, GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.userInformation(userName: userName))
    }

    /**
     특정 유저의 starred repository 정보를 요청합니다.
     - Author: 제균
     - parameters:
        - userName: GitHub userName
        - page: 요청할 page number
     - returns: 요청 성공시 특정 유저가 star를 눌러둔 레포지토리 목록을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestUserStarRepositories(userName: String, page: Int) async -> Result<[RepositoryResponse], GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.userStarRepositories(userName: userName, page: page))
    }

    /**
     특정 유저의 Following List 정보를 요청합니다.
     - Author: 한호
     - parameters:
        - userName: GitHub userName
        - perPage: page 당 요청할 개수(default: 30, max: 100)
        - page: 요청할 page number
     - returns: 요청 성공시 특정 유저의 Following 목록을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestUserFollowingList(userName: String, perPage: Int, page: Int) async -> Result<[FollowingResponse], GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.userFollowingList(userName: userName, perPage: perPage, page: page))
    }

    /**
     특정 유저의 Follower List 정보를 요청합니다.
     - Author: 한호
     - parameters:
        - userName: GitHub userName
        - perPage: page 당 요청할 개수(default: 30, max: 100)
        - page: 요청할 page numbe
     - returns: 요청 성공시 특정 유저의 Follower 목록을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestUserFollowerList(userName: String, perPage: Int, page: Int) async -> Result<[FollowingResponse], GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.userFollowerList(userName: userName, perPage: perPage, page: page))
    }

    /**
     특정 레포지토리의 정보를 요청합니다.
     - Author: 제균
     - parameters:
        - owner: 레포지토리 주인의 userName
        - repositoryName: 레포지토리의 이름
     - returns: 요청 성공시 레포지토리 모델을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestRepositoryInformation(owner: String, repositoryName: String) async -> Result<Repository, GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.repositoryInformation(owner: owner, repositoryName: repositoryName))
    }

    /**
     특정 레포지토리의 리드미를 요청합니다.
     - Author: 제균
     - parameters:
        - owner: 레포지토리 주인의 userName
        - repositoryName: 레포지토리의 이름
     - returns: 요청 성공시 레포지토리의 readme를 담고있는 모델을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestRepositoryReadme(owner: String, repositoryName: String) async -> Result<RepositoryReadmeResponse, GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.repositoryREADME(owner: owner, repositoryName: repositoryName))
    }

    /**
     마크다운 String을 HTML String으로 변환하도록 요청합니다.
     - Author: 제균
     - parameters:
        - content: html 문자열로 변환할 마크다운 문자열
     - returns: 요청 성공시 HTML 문자열을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestMarkdownToHTML(content: String) async -> Result<String, GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.markdownToHTML(markdownString: content))
    }

    /**
     특정 레포지토리의 contributor 목록을 요청합니다.
     - Author: 제균
     - parameters:
        - owner: 레포지토리 주인의 userName
        - repositoryName: 대상 레포지토리의 이름
        - page: 요청할 페이지 number
     - returns: 요청 성공시 성공했다는 Contributor의 목록을, 요청 실패시 GitHubAPIError를 가지는 Result 타입을 리턴합니다.
     */
    func requestRepositoryContributors(owner: String, repositoryName: String, page: Int) async -> Result<[ContributorProfile], GitHubError> {
        return await sendRequest(endpoint: GitHubEndpoint.repositoryContributors(owner: owner, repositoryName: repositoryName, page: page))
    }

}
