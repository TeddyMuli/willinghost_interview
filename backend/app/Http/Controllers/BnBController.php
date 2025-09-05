<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\BnB;

class BnBController extends Controller
{
    // Get all BnBs
    public function index()
    {
        return response()->json(BnB::all());
    }

    // Get a single BnB
    public function show($id)
    {
        $bnb = BnB::find($id);
        if (!$bnb) {
            return response()->json(['message' => 'BnB not found'], 404);
        }
        return response()->json($bnb);
    }

    // Create a new BnB
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:100',
            'location' => 'required|string',
            'price_per_night' => 'required|numeric',
            'availability' => 'boolean',
        ]);
        $bnb = BnB::create($validated);
        return response()->json($bnb, 201);
    }

    // Update a BnB
    public function update(Request $request, $id)
    {
        $bnb = BnB::find($id);
        if (!$bnb) {
            return response()->json(['message' => 'BnB not found'], 404);
        }
        $validated = $request->validate([
            'name' => 'sometimes|required|string|max:100',
            'location' => 'sometimes|required|string',
            'price_per_night' => 'sometimes|required|numeric',
            'availability' => 'sometimes|boolean',
        ]);
        $bnb->update($validated);
        return response()->json($bnb);
    }

    // Delete a BnB
    public function destroy($id)
    {
        $bnb = BnB::find($id);
        if (!$bnb) {
            return response()->json(['message' => 'BnB not found'], 404);
        }
        $bnb->delete();
        return response()->json(['message' => 'BnB deleted successfully']);
    }
}
