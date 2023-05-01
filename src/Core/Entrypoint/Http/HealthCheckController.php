<?php

declare(strict_types=1);

namespace YourCompany\Core\Entrypoint\Http;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

final class HealthCheckController
{
    #[Route(
        '/',
        name: 'health.check',
        methods: ['GET'],
    )]
    public function __invoke(): Response
    {
        return new JsonResponse(
            ['status' => 'ok'],
            Response::HTTP_OK,
        );
    }
}
