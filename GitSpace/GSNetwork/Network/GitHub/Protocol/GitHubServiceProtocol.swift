//
//  GitHubServiceProtocol.swift
//  GSNetwork
//
//  Created by 박제균 on 2/14/24.
//

import Foundation

protocol GitHubServiceProtocol {

    /// 인증된 사용자의 정보를 요청하는 함수
    func requestAuthenticatedUser() async -> Result<GithubUser, GitHubError>

    /// 인증된 사용자의 starred repository들을 요청하는 함수
    func requestAuthenticatedUserStars(page: Int) async -> Result<[RepositoryResponse], GitHubError>

    /// 인증된 사용자가 액세스 권한을 가진 repository들을 요청하는 함수
    func requestAuthenticatedUserRepositories(page: Int) async -> Result<[RepositoryResponse], GitHubError>

    /// 인증된 사용자가 팔로우하고 있는지의 여부를 확인하는 함수
    func requestAuthenticatedUserFollowsPerson(userName: String) async throws

    /// 인증된 사용자의 follower 목록을 요청하는 함수
    func requestAuthenticatedUserFollowers(perPage: Int, page: Int) async -> Result<[FollowerResponse], GitHubError>

    /// 인증된 사용자로 받은 이벤트를 요청하는 함수
    func requestAuthenticatedUserReceivedEvents(userName: String, page: Int) async -> Result<[Event],GitHubError>

    /// 인증된 사용자로 특정 레포지토리를 star할 때 사용하는 함수
    func requestToStarRepository(owner: String, repositoryName: String) async throws

    /// 인증된 사용자로 특정 레포지토리를 unstar할 때 사용하는 함수
    func requestToUnstarRepository(owner: String, repositoryName: String) async throws

    /// 특정 유저를 follow 할 때 사용하는 함수
    func requestToFollowUser(userName: String) async throws

    // 특정 유저를 unfollow 할 때 사용하는 함수
    func requestToUnfollowUser(userName: String) async throws

    /// 특정 유저의 정보를 요청하는 함수
    func requestUserInformation(userName: String) async -> Result<GithubUser, GitHubError>

    /// 특정 유저의 starred repository들을 요청하는 함수
    func requestUserStarRepositories(userName: String, page: Int) async -> Result<[RepositoryResponse], GitHubError>

    /// 특정 유저의 Following List를 요청하는 함수
    func requestUserFollowingList(userName: String, perPage: Int, page: Int) async -> Result<[FollowingResponse], GitHubError>

    /// 특정 유저의 Follower List를 요청하는 함수
    func requestUserFollowerList(userName: String, perPage: Int, page: Int) async -> Result<[FollowingResponse], GitHubError>

    /// 특정 레포지토리의 정보를 요청하는 함수
    func requestRepositoryInformation(owner: String, repositoryName: String) async -> Result<Repository, GitHubError>

    /// 특정 레포지토리의 리드미를 요청하는 함수
    func requestRepositoryReadme(owner: String, repositoryName: String) async -> Result<RepositoryReadmeResponse, GitHubError>

    /// 마크다운 text를 HTML로 변환하는 함수
    func requestMarkdownToHTML(content: String) async -> Result<String, GitHubError>

    /// 특정 레포지토리의 contributor 목록을 요청하는 함수
    func requestRepositoryContributors(owner: String, repositoryName: String, page: Int) async -> Result<[ContributorProfile], GitHubError>

    // TODO: - 필요한 API 기능을 추가로 작성합니다.
}
