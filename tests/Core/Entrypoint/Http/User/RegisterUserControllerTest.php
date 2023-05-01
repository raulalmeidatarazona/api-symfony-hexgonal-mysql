<?php

declare(strict_types=1);

namespace YourCompany\Tests\Core\Entrypoint\Http\User;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;

final class RegisterUserControllerTest extends WebTestCase
{
    private const REGISTER_ENDPOINT = 'core/v1/users/register';

    public function setUp(): void
    {
        parent::setUp();
    }

    /** @test */
    public function given_post_request_with_valid_user_data_when_register_endpoint_is_called_then_returns_authentication_token(
    ): void
    {
        $client = static::createClient();

        $requestData = [
            'id' => '123e4567-e89b-12d3-a456-426614174000',
            'name' => 'John Doe',
            'email' => 'johndoe@email.com',
            'password' => 'aA1234_',
            'password_confirmation' => 'aA1234_',
        ];

        $client->request(
            Request::METHOD_POST,
            self::REGISTER_ENDPOINT,
            [],
            [],
            [],
            json_encode($requestData)
        );

        $response = $client->getResponse();

        self::assertSame(JsonResponse::HTTP_CREATED, $response->getStatusCode());
        self::assertNotEmpty($response->getContent());

        $responseData = json_decode($response->getContent(), true);

        self::assertArrayHasKey('token', $responseData);
        self::assertNotEmpty($responseData['token']);
    }

}
