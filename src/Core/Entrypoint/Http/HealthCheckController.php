<?php

declare(strict_types=1);

namespace YourCompany\Core\Entrypoint\Http;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

final class HealthCheckController
{
    public function __invoke(): JsonResponse
    {
        return new JsonResponse(
            ['status' => 'ok'],
            Response::HTTP_OK
        );
    }
}
