<?php

declare(strict_types=1);

namespace YourCompany\Core\Entrypoint\Http\User;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

final class RegisterUserController
{
    public function register(Request $request): JsonResponse
    {
        $body = new ParameterBag(
            json_decode(
                $request->getContent(),
                true,
            ),
        );

        return new JsonResponse(
            ['token' => $body->get('id')],
            Response::HTTP_CREATED
        );
    }
}
