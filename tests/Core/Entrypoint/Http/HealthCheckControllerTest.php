<?php

declare(strict_types=1);

namespace YourCompany\Tests\Core\Entrypoint\Http;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;

final class HealthCheckControllerTest extends WebTestCase
{
    private const HEALTH_CHECK_ENDPOINT = '/health-check';

    /** @test */
    public function given_get_request_to_root_when_health_check_endpoint_is_called_then_returns_successful_json_response(
    ): void
    {
        $client = static::createClient();

        $client->request(
            Request::METHOD_GET,
            self::HEALTH_CHECK_ENDPOINT
        );

        $response = $client->getResponse();

        self::assertSame(JsonResponse::HTTP_OK, $response->getStatusCode());
        self::assertSame(
            '{"status":"ok"}',
            $response->getContent(),
        );
    }
}
