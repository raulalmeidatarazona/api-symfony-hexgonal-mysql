<?php

declare(strict_types=1);

namespace YourCompany\Tests\Core\Entrypoint\Http;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

final class HealthCheckControllerTest extends WebTestCase
{
    /** @test */
    public function given_get_request_to_root_when_health_check_endpoint_is_called_then_returns_successful_json_response(
    ): void
    {
        $client = static::createClient();

        $client->request('GET', '/');

        $response = $client->getResponse();

        self::assertSame(200, $response->getStatusCode());
        self::assertSame(
            '{"status":"ok"}',
            $response->getContent(),
        );
    }
}
